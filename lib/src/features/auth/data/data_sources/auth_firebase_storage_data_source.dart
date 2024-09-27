import 'dart:io';
import 'package:cinequest/src/common/constants/app_keys.dart';
import 'package:cinequest/src/core/errors/exceptions/firebase_network_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/save_profile_params.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Sử dụng Firebase Storage

abstract class AuthFirebaseStorageDataSource {
  ///
  Future<String> saveProfilePhoto(SaveProfilePhotoParams params);
}

/// Implementation của AuthFirebaseStorageDataSource
class AuthFirebaseStorageDataSourceImpl
    implements AuthFirebaseStorageDataSource {
  /// Constructor
  AuthFirebaseStorageDataSourceImpl({
    required FirebaseStorage storage,
  }) : _storage = storage;
  final FirebaseStorage _storage;

  @override
  Future<String> saveProfilePhoto(SaveProfilePhotoParams params) async {
    try {
      final ref = _storage.ref(profilePhotoStorageKey).child(params.userId);
      final snapshot = await ref.putFile(File(params.profilePhoto));
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw Failure(
        message: FirebaseNetworkException.fromFirebaseException(e).message,
      );
    }
  }
}
