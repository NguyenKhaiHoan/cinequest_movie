import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_cloud_firestore_data_source.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_firebase_data_source.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_firebase_storage_data_source.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_local_storage_data_source.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/save_profile_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/verification_code_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Implementation của AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  ///Constructor
  AuthRepositoryImpl({
    required AuthFirebaseDataSource authFirebaseDataSource,
    required AuthCloudFirestoreDataSource authCloudFirestoreDataSource,
    required AuthFirebaseStorageDataSource authFirebaseStorageDataSource,
    required AuthLocalStorageDataSource authLocalStorageDataSource,
  })  : _authFirebaseDataSource = authFirebaseDataSource,
        _authCloudFirestoreDataSource = authCloudFirestoreDataSource,
        _authFirebaseStorageDataSource = authFirebaseStorageDataSource,
        _authLocalStorageDataSource = authLocalStorageDataSource;
  final AuthFirebaseDataSource _authFirebaseDataSource;
  final AuthCloudFirestoreDataSource _authCloudFirestoreDataSource;
  final AuthFirebaseStorageDataSource _authFirebaseStorageDataSource;
  final AuthLocalStorageDataSource _authLocalStorageDataSource;

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
      final result = await _authCloudFirestoreDataSource.saveProfileUser(
        params,
      );
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<String> saveProfilePhoto(SaveProfilePhotoParams params) async {
    try {
      final result = await _authFirebaseStorageDataSource.saveProfilePhoto(
        params,
      );
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<AuthParams> getEmailPassword() async {
    try {
      final result = await _authLocalStorageDataSource.getEmailPassword();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> saveEmailPassword(AuthParams params) async {
    try {
      final result =
          await _authLocalStorageDataSource.saveEmailPassword(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
