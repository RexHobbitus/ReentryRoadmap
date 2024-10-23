import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

///
///
/// THIS IS A MIXIN, YOU CAN USE WITH ANY REPOSITORY CLASS TO USE THEIR FUNCTIONS OR FEATURES
///

mixin FirebaseFunctions {

  /// UPLOAD SINGLE FILE TO FIREBASE AND GET URL
  Future<String> uploadFile(dynamic file) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child('uploads/${DateTime.now().millisecondsSinceEpoch}');

      // For mobile (File) case
      if (file is File) {
        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      }
      // For web (Uint8List) case
      else if (file is Uint8List) {
        UploadTask uploadTask = ref.putData(file);
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      } else {
        throw 'Unsupported file type';
      }
    } catch (e) {
      throw 'Error uploading file: $e';
    }
  }

  Future<List<String>> uploadFiles(List<dynamic> files) async {
    try {
      // Create a list of Future tasks for each file upload
      List<Future<String>> uploadTasks =
          files.map((file) => uploadFile(file)).toList();

      // Use Future.wait to wait for all uploads to complete
      List<String> downloadUrls = await Future.wait(uploadTasks);
      debugPrint("+++++++++++++ IMAGES ARE UPLOADED +++++++++");
      debugPrint(downloadUrls.toString());

      return downloadUrls;
    } catch (e) {
      throw 'Error uploading files: $e';
    }
  }
}
