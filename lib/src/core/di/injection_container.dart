part of 'injection_container.import.dart';

/// Khởi tạo App
Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  await initDependencies();
}

/// Khởi tạo Firebase
Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

/// Khởi tạo phụ thuộc
Future<void> initDependencies() async {
  sl
    // Dio: registerLazySingleton
    ..registerLazySingleton<DioClient>(DioClient.new)

    // Firebase & Google: registerLazySingleton
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance)
    ..registerLazySingleton<GoogleSignIn>(GoogleSignIn.new)

    // Common: registerLazySingleton
    ..registerLazySingleton<ConnectivityBloc>(
      () => ConnectivityBloc(connectivityService: sl<ConnectivityService>()),
    )

    // External Dependencies: registerLazySingleton
    ..registerLazySingleton<TMDBApi>(() => TMDBApi(sl<DioClient>().dio))
    ..registerLazySingleton<ConnectivityService>(ConnectivityService.new)
    ..registerLazySingleton<GetStorageService>(GetStorageService.new)
    ..registerLazySingleton<SharedPreferencesService>(
      SharedPreferencesService.new,
    )
    ..registerLazySingleton<SqliteService>(
      SqliteService.new,
    )
    ..registerLazySingleton<SecureStorageService>(
      SecureStorageService.new,
    )

    // Data Sources: registerLazySingleton
    ..registerLazySingleton<MovieApiNetworkDataSource>(
      () => MovieApiNetworkDataSourceImpl(tmdbApi: sl<TMDBApi>()),
    )
    ..registerLazySingleton<AuthFirebaseDataSource>(
      () => AuthFirebaseDataSourceImpl(
        firebaseAuth: sl<FirebaseAuth>(),
        googleSignIn: sl<GoogleSignIn>(),
      ),
    )
    ..registerLazySingleton<AuthCloudFirestoreDataSource>(
      () =>
          AuthCloudFirestoreDataSourceImpl(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<AuthFirebaseStorageDataSource>(
      () => AuthFirebaseStorageDataSourceImpl(storage: sl<FirebaseStorage>()),
    )
    ..registerLazySingleton<MovieLocalDataSource>(
      () => MovieSqliteServiceDataSourceImpl(
        sqliteService: sl<SqliteService>(),
      ),
    )
    ..registerLazySingleton<AuthLocalStorageDataSource>(
      () => AuthSecureStorageDataSourceImpl(
        secureStorageService: sl<SecureStorageService>(),
      ),
    )

    // Repositories: registerLazySingleton
    ..registerLazySingleton<UserRepository>(UserRepositoryImpl.new)
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
        movieApiNetworkDataSource: sl<MovieApiNetworkDataSource>(),
        movieLocalDataSource: sl<MovieLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authFirebaseDataSource: sl<AuthFirebaseDataSource>(),
        authCloudFirestoreDataSource: sl<AuthCloudFirestoreDataSource>(),
        authFirebaseStorageDataSource: sl<AuthFirebaseStorageDataSource>(),
        authLocalStorageDataSource: sl<AuthLocalStorageDataSource>(),
      ),
    )

    // Use Cases: registerLazySingleton
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
    ..registerLazySingleton<GetNowPlayingMoviesUseCase>(
      () => GetNowPlayingMoviesUseCase(sl<MovieRepository>()),
    )
    ..registerLazySingleton<GetPopularMoviesUseCase>(
      () => GetPopularMoviesUseCase(sl<MovieRepository>()),
    )
    ..registerLazySingleton<GetProfileUserUseCase>(
      () => GetProfileUserUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<SaveProfileUseCase>(
      () => SaveProfileUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<SaveMovieLocalUseCase>(
      () => SaveMovieLocalUseCase(sl<MovieRepository>()),
    )

    // App Logic: registerFactory
    ..registerFactory<AppBloc>(
      () => AppBloc(
        firebaseAuth: sl<FirebaseAuth>(),
        getProfileUserUseCase: sl<GetProfileUserUseCase>(),
        userRepository: sl<UserRepository>(),
        getStorageService: sl<GetStorageService>(),
      ),
    )
    ..registerFactory<AccountSetupBloc>(AccountSetupBloc.new);
}
