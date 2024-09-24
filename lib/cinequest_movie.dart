import 'package:cinequest/src/common/bloc/app/app_auth_bloc.dart';
import 'package:cinequest/src/core/errors/exceptions/no_internet_exception.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/core/themes/app_themes.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/bloc/connectivity/connectivity_bloc.dart';
import 'src/core/injection_container.dart';

part 'cinequest_movie.mixin.dart';

class CineQuestMovie extends StatefulWidget {
  const CineQuestMovie({super.key});

  @override
  State<CineQuestMovie> createState() => _CineQuestMovieState();
}

class _CineQuestMovieState extends State<CineQuestMovie>
    with CineQuestMovieMixin {
  final router = RouterPages.router;

  @override
  Widget build(BuildContext context) {
    UiUtil.initialize(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityBloc(sl()),
        ),
        BlocProvider(
          create: (context) =>
              AppAuthBloc(firebaseAuth: sl(), useCase: sl(), repository: sl())
                ..add(const AppAuthEvent.started()),
        ),
      ],
      child: MaterialApp.router(
        theme: AppThemes.darkTheme,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        builder: (context, child) {
          return Scaffold(
            body: MultiBlocListener(
              listeners: [
                BlocListener<ConnectivityBloc, ConnectivityState>(
                  listener: _listenerConnectivity,
                ),
                BlocListener<AppAuthBloc, AppAuthState>(
                  listener: _listenerAppAuth,
                ),
              ],
              child: BlocBuilder<AppAuthBloc, AppAuthState>(
                builder: (context, state) {
                  return child!;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
