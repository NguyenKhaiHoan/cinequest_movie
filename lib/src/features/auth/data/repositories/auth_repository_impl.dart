import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_firebase_data_source.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_firebase_storage_data_source.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/save_profile_photo_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/save_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/verification_code_params.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/generics/type_def.dart';
import '../../domain/entities/params/auth_params.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_cloud_firestore_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource _authFirebaseDataSource;
  final AuthCloudFirestoreDataSource _authCloudFirestoreDataSource;
  final AuthFirebaseStorageDataSource _authFirebaseStorageDataSource;

  AuthRepositoryImpl({
    required AuthFirebaseDataSource authFirebaseDataSource,
    required AuthCloudFirestoreDataSource authCloudFirestoreDataSource,
    required AuthFirebaseStorageDataSource authFirebaseStorageDataSource,
  })  : _authFirebaseDataSource = authFirebaseDataSource,
        _authCloudFirestoreDataSource = authCloudFirestoreDataSource,
        _authFirebaseStorageDataSource = authFirebaseStorageDataSource;

  @override
  FutureEither<UserCredential> login(AuthParams params) async {
    try {
      final result = await _authFirebaseDataSource.login(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<UserCredential> signUp(AuthParams params) async {
    try {
      final result = await _authFirebaseDataSource.signUp(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<UserCredential> signInWithGoogle() async {
    try {
      final result = await _authFirebaseDataSource.signInWithGoogle();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> signOut() async {
    try {
      final result = await _authFirebaseDataSource.signOut();
      // Đặt lại path bằng rỗng để tránh bị xét lại rằng đã có
      // path của welcome page, home page do đã được thêm vào từ trước
      RouterPages.refeshPath();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> verificateCode(VerificationCodeParams params) async {
    try {
      final result = await _authFirebaseDataSource.verificateCode(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<AppUser> getProfileUser(GetProfileUserParams params) async {
    try {
      final result = await _authCloudFirestoreDataSource.getProfileUser(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> saveProfileUser(SaveProfileUserParams params) async {
    try {
      final user = params.user;
      final profilePhoto = await _authFirebaseStorageDataSource
          .saveProfilePhoto(SaveProfilePhotoParams(
              profilePhoto: user.profilePhoto, userId: user.id));
      final result = await _authCloudFirestoreDataSource.saveProfileUser(
        params.copyWith(
          user: user.copyWith(profilePhoto: profilePhoto),
        ),
      );
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
