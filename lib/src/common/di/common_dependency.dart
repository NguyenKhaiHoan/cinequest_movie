import 'package:cinequest/src/common/bloc/app/app_bloc.dart';
import 'package:cinequest/src/common/bloc/connectivity/connectivity_bloc.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/core/repositories/user_repository.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';
import 'package:cinequest/src/external/services/storage/local/get_storage_service.dart';
import 'package:cinequest/src/features/auth/domain/usecases/get_profile_user_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommonDependency {
  CommonDependency._();

  static void init() {
    sl
      ..registerFactory<AppBloc>(
        () => AppBloc(
          firebaseAuth: sl<FirebaseAuth>(),
          getProfileUserUseCase: sl<GetProfileUserUseCase>(),
          userRepository: sl<UserRepository>(),
          getStorageService: sl<GetStorageService>(),
        ),
      )
      ..registerFactory<ConnectivityBloc>(
        () => ConnectivityBloc(connectivityService: sl<ConnectivityService>()),
      );
  }
}
