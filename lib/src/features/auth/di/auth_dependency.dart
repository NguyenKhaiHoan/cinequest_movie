part of 'auth_dependency.import.dart';

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
