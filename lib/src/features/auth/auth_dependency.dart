import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:cinequest/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/get_email_password_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/get_profile_user_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/save_email_password_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/save_profile_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/verificate_code_usecase.dart';

class AuthDependency {
  AuthDependency._();

  static void init() {
    sl
      // Data Sources: registerLazySingleton
      ..registerLazySingleton<AuthRemoteDataSource>(
        AuthFirebaseDataSourceImpl.new,
      )
      ..registerLazySingleton<AuthLocalDataSource>(
        () => AuthSecureStorageDataSourceImpl(
          secureStorageService: sl<SecureStorageService>(),
        ),
      )

      // Repositories: registerLazySingleton
      ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
          authRemoteDataSource: sl<AuthRemoteDataSource>(),
          authLocalDataSource: sl<AuthLocalDataSource>(),
        ),
      )

      // Use Cases: registerLazySingleton
      ..registerLazySingleton<GetProfileUserUseCase>(
        () => GetProfileUserUseCase(sl<AuthRepository>()),
      )
      ..registerLazySingleton<SaveProfileUserUseCase>(
        () => SaveProfileUserUseCase(sl<AuthRepository>()),
      )
      ..registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(sl<AuthRepository>()),
      )
      ..registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCase(sl<AuthRepository>()),
      )
      ..registerLazySingleton<SignInWithGoogleUseCase>(
        () => SignInWithGoogleUseCase(sl<AuthRepository>()),
      )
      ..registerLazySingleton<VerificateCodeUseCase>(
        () => VerificateCodeUseCase(sl<AuthRepository>()),
      )
      ..registerLazySingleton<SignOutUseCase>(
        () => SignOutUseCase(sl<AuthRepository>()),
      )
      ..registerLazySingleton<GetEmailPasswordUseCase>(
        () => GetEmailPasswordUseCase(sl<AuthRepository>()),
      )
      ..registerLazySingleton<SaveEmailPasswordUseCase>(
        () => SaveEmailPasswordUseCase(sl<AuthRepository>()),
      );
  }
}
