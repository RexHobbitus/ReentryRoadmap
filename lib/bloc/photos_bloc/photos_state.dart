import 'package:equatable/equatable.dart';

class PhotosState extends Equatable {
  final String? coverPhotoUrl;
  final List<String> otherPhotos;
  final bool isLoading;

  PhotosState({
    this.coverPhotoUrl,
    this.otherPhotos = const [],
    this.isLoading = false,
  });

  PhotosState copyWith({
    String? coverPhotoUrl,
    List<String>? otherPhotos,
    bool? isLoading,
  }) {
    return PhotosState(
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
      otherPhotos: otherPhotos ?? this.otherPhotos,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [coverPhotoUrl, otherPhotos, isLoading];
}
