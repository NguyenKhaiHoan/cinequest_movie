import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/profile_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/user_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/verification_code_params.dart';
import 'package:dartz/dartz.dart';

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
  FutureEither<AppUser> getProfileUser() async {
    try {
      final result = await _authRemoteDataSource.getProfileUser();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> saveProfileUser(UserParams params) async {
    try {
      final result = await _authRemoteDataSource.saveProfileUser(
        user: params.user,
      );
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> login(AuthParams params) async {
    try {
      await _authRemoteDataSource.login(
        email: params.email,
        password: params.password,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> signUp(AuthParams params) async {
    try {
      await _authRemoteDataSource.signUp(
        email: params.email,
        password: params.password,
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> signInWithGoogle() async {
    try {
      await _authRemoteDataSource.signInWithGoogle();
      return const Right(null);
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
  FutureEither<void> verificateCode(VerificattionCodeParams params) async {
    try {
      final result = await _authRemoteDataSource.verificateCode(
        verificationCode: params.verificationCode,
      );
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<String> saveProfilePhoto(ProfileParams params) async {
    try {
      final result = await _authRemoteDataSource.saveProfilePhoto(
        profilePhoto: params.profilePhoto,
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
      final result = await _authLocalDataSource.saveEmailPassword(
        email: params.email,
        password: params.password,
      );
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
