import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/save_profile_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/verification_code_params.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Implementation của AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  ///Constructor
  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required AuthLocalDataSource authLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDataSource = authLocalDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  FutureEither<AppUser> getProfileUser(GetProfileUserParams params) async {
    try {
      final result = await _authRemoteDataSource.getProfileUser(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> saveProfileUser(SaveProfileUserParams params) async {
    try {
      final result = await _authRemoteDataSource.saveProfileUser(
        params,
      );
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<UserCredential> login(AuthParams params) async {
    try {
      final result = await _authRemoteDataSource.login(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<UserCredential> signUp(AuthParams params) async {
    try {
      final result = await _authRemoteDataSource.signUp(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<UserCredential> signInWithGoogle() async {
    try {
      final result = await _authRemoteDataSource.signInWithGoogle();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> signOut() async {
    try {
      final result = await _authRemoteDataSource.signOut();
      // Đặt lại path bằng rỗng để tránh bị xét lại rằng đã có
      // path của welcome page, home page do đã được thêm vào từ trước
      RouterPages.refreshPath();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> verificateCode(VerificateCodeParams params) async {
    try {
      final result = await _authRemoteDataSource.verificateCode(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<String> saveProfilePhoto(SaveProfilePhotoParams params) async {
    try {
      final result = await _authRemoteDataSource.saveProfilePhoto(
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
      final result = await _authLocalDataSource.getEmailPassword();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> saveEmailPassword(AuthParams params) async {
    try {
      final result = await _authLocalDataSource.saveEmailPassword(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
