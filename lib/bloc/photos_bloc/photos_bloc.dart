import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils/pref_utils.dart';
import 'photos_event.dart';
import 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final ImagePicker _picker = ImagePicker();

  PhotosBloc() : super(PhotosState()) {
    on<LoadPhotos>(_loadPhotos);
    on<PickCoverPhoto>(_pickCoverPhoto);
    on<PickNewPhoto>(_pickNewPhoto);
    on<DeletePhoto>(_deletePhoto);
    on<EditPhoto>(_editPhoto);
  }

  Future<void> _loadPhotos(LoadPhotos event, Emitter<PhotosState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      String userId = PrefUtil.getString(PrefUtil.userId);

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('photos')
          .doc(userId)
          .get();

      final data = snapshot.data() as Map<String, dynamic>?;

      String? coverPhotoUrl = data?['coverImage'];
      List<String> otherPhotos = List<String>.from(data?['photos'] ?? []);

      emit(state.copyWith(
        coverPhotoUrl: coverPhotoUrl,
        otherPhotos: otherPhotos,
        isLoading: false,
      ));
    } catch (e) {
      print("Failed to load photos: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _pickCoverPhoto(
      PickCoverPhoto event, Emitter<PhotosState> emit) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String downloadUrl = await _uploadImage(image, 'coverImage');
      String userId = PrefUtil.getString(PrefUtil.userId);

      await FirebaseFirestore.instance.collection('photos').doc(userId).set(
        {'coverImage': downloadUrl},
        SetOptions(merge: true),
      );
      emit(state.copyWith(coverPhotoUrl: downloadUrl));
    }
  }

  Future<void> _pickNewPhoto(
      PickNewPhoto event, Emitter<PhotosState> emit) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String downloadUrl = await _uploadImage(
          image, 'photos/${DateTime.now().millisecondsSinceEpoch}');
      String userId = PrefUtil.getString(PrefUtil.userId);

      await FirebaseFirestore.instance.collection('photos').doc(userId).update({
        'photos': FieldValue.arrayUnion([downloadUrl]),
      });
      emit(state.copyWith(
          otherPhotos: List.from(state.otherPhotos)..add(downloadUrl)));
    }
  }

  Future<void> _deletePhoto(
      DeletePhoto event, Emitter<PhotosState> emit) async {
    try {
      // Remove the photo from Firestore
      String userId = PrefUtil.getString(PrefUtil.userId);

      await FirebaseFirestore.instance.collection('photos').doc(userId).update({
        'photos': FieldValue.arrayRemove([event.photoUrl]),
      });

      // Update state
      emit(state.copyWith(
        otherPhotos: List.from(state.otherPhotos)..remove(event.photoUrl),
      ));
    } catch (e) {
      print("Failed to delete photo: $e");
    }
  }

  Future<void> _editPhoto(EditPhoto event, Emitter<PhotosState> emit) async {
    try {
      // Allow the user to pick a new image for editing
      final XFile? newImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (newImage != null) {
        // Upload new image to Firebase Storage
        String newDownloadUrl = await _uploadImage(
            newImage, 'photos/${DateTime.now().millisecondsSinceEpoch}');

        // Replace the old photo URL with the new one in Firestore
        String userId = PrefUtil.getString(PrefUtil.userId);

        await FirebaseFirestore.instance
            .collection('photos')
            .doc(userId)
            .update({
          'photos': FieldValue.arrayRemove([event.photoUrl]), // Remove old URL
        });

        await FirebaseFirestore.instance
            .collection('photos')
            .doc(userId)
            .update({
          'photos': FieldValue.arrayUnion([newDownloadUrl]), // Add new URL
        });

        // Update local state with new photo URL
        List<String> updatedPhotos = List.from(state.otherPhotos)
          ..remove(event.photoUrl)
          ..add(newDownloadUrl);

        emit(state.copyWith(otherPhotos: updatedPhotos));
      }
    } catch (e) {
      print("Failed to edit photo: $e");
    }
  }

  Future<String> _uploadImage(XFile image, String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putData(await image.readAsBytes());
    return await ref.getDownloadURL();
  }
}
