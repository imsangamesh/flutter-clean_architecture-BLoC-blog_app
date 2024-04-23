import 'dart:io';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorageApi {
  FireStorageApi({required FirebaseStorage firebaseStorage})
      : _fireStorage = firebaseStorage;

  final FirebaseStorage _fireStorage;

  Future<String?> storeFile({
    required String path,
    required String id,
    required File file,
  }) async {
    try {
      final uploadTask =
          await _fireStorage.ref().child(path).child(id).putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw ApiException(e.message.toString());
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
