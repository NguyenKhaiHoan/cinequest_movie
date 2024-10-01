import 'package:cinequest/src/common/bloc/app/app_bloc.dart';
import 'package:cinequest/src/common/bloc/connectivity/connectivity_bloc.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';
import 'package:cinequest/src/features/auth/domain/usecases/get_profile_user_usecase.dart';

class CommonDependency {
  CommonDependency._();

  static void init() {
    sl
      ..registerFactory<AppBloc>(
        () => AppBloc(
          getProfileUserUseCase: sl<GetProfileUserUseCase>(),
        ),
      )
      ..registerFactory<ConnectivityBloc>(
        () => ConnectivityBloc(connectivityService: sl<ConnectivityService>()),
      );
  }
}
