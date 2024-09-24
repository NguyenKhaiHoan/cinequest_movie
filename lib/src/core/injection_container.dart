import 'package:cinequest/firebase_options.dart';
import 'package:cinequest/src/common/bloc/app/app_auth_bloc.dart';
import 'package:cinequest/src/common/bloc/connectivity/connectivity_bloc.dart';
import 'package:cinequest/src/core/network/dio_client.dart';
import 'package:cinequest/src/core/repositories/user_repository.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';
import 'package:cinequest/src/external/services/storage/local/get_storage_service.dart';
import 'package:cinequest/src/external/services/storage/local/shared_preferences_service.dart';
import 'package:cinequest/src/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:cinequest/src/features/movie/domain/usecases/get_now_playing_movies_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../features/auth/data/data_sources/auth_cloud_firestore_data_source.dart';
import '../features/auth/data/data_sources/auth_firebase_data_source.dart';
import '../features/auth/data/data_sources/auth_firebase_storage_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/get_profile_user_use_case.dart';
import '../features/auth/domain/usecases/login_use_case.dart';
import '../features/auth/presentation/blocs/account_setup/account_setup_bloc.dart';
import '../features/movie/data/repositories/movie_repository_impl.dart';
import '../features/movie/domain/repositories/movie_repository.dart';
import '../features/movie/domain/usecases/get_popular_movie_use_case.dart';

final sl = GetIt.instance;

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  await initDependencies();
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> initDependencies() async {
  sl
    // Dio: registerLazySingleton
    ..registerLazySingleton<DioClient>(() => DioClient())

    // Firebase & Google: registerLazySingleton
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance)
    ..registerLazySingleton<GoogleSignIn>(() => GoogleSignIn())

    // Common: registerLazySingleton
    ..registerLazySingleton<ConnectivityBloc>(
        () => ConnectivityBloc(sl<ConnectivityService>()))

    // External Dependencies: registerLazySingleton
    ..registerLazySingleton<TMDBApi>(() => TMDBApi(sl<DioClient>().dio))
    ..registerLazySingleton<ConnectivityService>(() => ConnectivityService())
    ..registerLazySingleton<GetStorageService>(() => GetStorageService())
    ..registerLazySingleton<SharedPreferencesService>(
        () => SharedPreferencesService())

    // Data Sources: registerLazySingleton
    ..registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSourceImpl(tmdbApi: sl<TMDBApi>()))
    ..registerLazySingleton<AuthFirebaseDataSource>(() =>
        AuthFirebaseDataSourceImpl(
            firebaseAuth: sl<FirebaseAuth>(), googleSignIn: sl<GoogleSignIn>()))
    ..registerLazySingleton<AuthCloudFirestoreDataSource>(() =>
        AuthCloudFirestoreDataSourceImpl(firestore: sl<FirebaseFirestore>()))
    ..registerLazySingleton<AuthFirebaseStorageDataSource>(
        () => AuthFirebaseStorageDataSourceImpl(storage: sl<FirebaseStorage>()))

    // Repositories: registerLazySingleton
    ..registerLazySingleton<UserRepository>(() => UserRepositoryImpl())
    ..registerLazySingleton<MovieRepository>(() =>
        MovieRepositoryImpl(movieRemoteDataSource: sl<MovieRemoteDataSource>()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authFirebaseDataSource: sl<AuthFirebaseDataSource>(),
        authCloudFirestoreDataSource: sl<AuthCloudFirestoreDataSource>(),
        authFirebaseStorageDataSource: sl<AuthFirebaseStorageDataSource>()))

    // Use Cases: registerLazySingleton
    ..registerLazySingleton<GetNowPlayingMoviesUseCase>(
        () => GetNowPlayingMoviesUseCase(sl<MovieRepository>()))
    ..registerLazySingleton<GetPopularMoviesUseCase>(
        () => GetPopularMoviesUseCase(sl<MovieRepository>()))
    ..registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(sl<AuthRepository>()))
    ..registerLazySingleton<GetProfileUserUseCase>(
        () => GetProfileUserUseCase(sl<AuthRepository>()))

    // App Logic: registerFactory
    ..registerFactory<AppAuthBloc>(() => AppAuthBloc(
        firebaseAuth: sl<FirebaseAuth>(),
        useCase: sl<GetProfileUserUseCase>(),
        repository: sl<UserRepository>()))
    ..registerFactory<AccountSetupBloc>(() => AccountSetupBloc());
}
