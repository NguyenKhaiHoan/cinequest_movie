import 'package:cinequest/src/common/bloc/app/app_auth_bloc.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/core/themes/app_themes.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/bloc/connectivity/connectivity_bloc.dart';
import 'src/core/injection_container.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with MyAppMixin {
  final router = RouterPages.createRouter(sl<AppAuthBloc>());

  @override
  Widget build(BuildContext context) {
    UiUtil.initialize(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityBloc(),
        ),
        BlocProvider(
          create: (context) => AppAuthBloc()..add(const AppAuthEvent.started()),
        ),
      ],
      child: MaterialApp.router(
        theme: AppThemes.darkTheme,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        builder: (context, child) {
          return Scaffold(
            body: BlocListener<ConnectivityBloc, ConnectivityState>(
              listener: (context, state) => _listener,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

mixin MyAppMixin on State<MyApp> {
  void _listener(BuildContext context, ConnectivityState state) {
    state.whenOrNull(
        failure: () => context.showSnackbar('No internet connected'));
  }
}
