import 'package:cinequest/src/common/bloc/app/app_auth_bloc.dart';
import 'package:cinequest/src/common/bloc/connectivity/connectivity_bloc.dart';
import 'package:get_it/get_it.dart';

import '../features/auth/presentation/blocs/account_setup/account_setup_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl
    // Common: registerLazySingleton
    ..registerLazySingleton<ConnectivityBloc>(() => ConnectivityBloc())

    // External Dependencies: registerLazySingleton

    // App Logic: registerFactory
    ..registerFactory<AppAuthBloc>(() => AppAuthBloc())
    ..registerFactory<AccountSetupBloc>(() => AccountSetupBloc());

  // Data Sources: registerLazySingleton

  // Repositories: registerLazySingleton

  // Use Cases: registerLazySingleton
}
