// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cinequest/src/core/errors/exceptions/firebase_network_exception.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/params/save_profile_photo_params.dart';

abstract class AuthFirebaseStorageDataSource {
  Future<String> saveProfilePhoto(SaveProfilePhotoParams params);
}

class AuthFirebaseStorageDataSourceImpl
    implements AuthFirebaseStorageDataSource {
  final FirebaseStorage _storage;

  AuthFirebaseStorageDataSourceImpl({
    required FirebaseStorage storage,
  }) : _storage = storage;

  @override
  Future<String> saveProfilePhoto(SaveProfilePhotoParams params) async {
    try {
      Reference ref = _storage.ref('ProfilePhotos').child(params.userId);
      TaskSnapshot snapshot = await ref.putFile(File(params.profilePhoto));
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw Failure(
          message: FirebaseNetworkException.fromFirebaseException(e).message);
    }
  }
}
