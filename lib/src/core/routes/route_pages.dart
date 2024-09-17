import 'package:cinequest/src/common/bloc/app/app_auth_bloc.dart';
import 'package:cinequest/src/core/routes/go_router_refresh_stream.dart';
import 'package:cinequest/src/features/auth/presentation/pages/account_setup_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/login_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/welcome_page.dart';
import 'package:cinequest/src/features/navigation/presentation/pages/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../enums/app_routes.dart';

final class RouterPages {
  RouterPages._();

  static GoRouter createRouter(AppAuthBloc appAuthBloc) => GoRouter(
        debugLogDiagnostics: true,
        initialLocation: AppRoutes.welcome.path,
        refreshListenable: GoRouterRefreshStream(appAuthBloc.stream),
        redirect: (context, state) => _guard(context, state, appAuthBloc),
        routes: [
          GoRoute(
            path: AppRoutes.welcome.path,
            builder: (context, state) => const WelcomePage(),
          ),
          GoRoute(
            path: AppRoutes.navigation.path,
            builder: (context, state) => const NavigationPage(),
          ),
          GoRoute(
            path: AppRoutes.login.path,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: AppRoutes.signUp.path,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: AppRoutes.accountSetup.path,
            builder: (context, state) => const AccountSetupPage(),
          ),
          GoRoute(
            path: AppRoutes.resetPassword.path,
            builder: (context, state) => const ResetPasswordPage(),
          ),
        ],
      );

  static String? _guard(
      BuildContext context, GoRouterState state, AppAuthBloc appAuthBloc) {
    final isAuthenticated = appAuthBloc.state is AppAuthenticatedState;
    final isUnAuthenticated = appAuthBloc.state is AppUnAuthenticatedState;

    if (isUnAuthenticated &&
        !state.matchedLocation.contains(AppRoutes.welcome.path)) {
      return AppRoutes.welcome.path;
    } else if (isAuthenticated) {
      return AppRoutes.navigation.path;
    }

    return null;
  }
}
