import 'package:cinequest/src/common/bloc/app/app_auth_bloc.dart';
import 'package:cinequest/src/core/utils/page_transition_util.dart';
import 'package:cinequest/src/features/auth/presentation/pages/account_setup_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/login_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/splash_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/welcome_page.dart';
import 'package:cinequest/src/features/movie/presentation/pages/profile_page.dart';
import 'package:cinequest/src/features/movie/presentation/pages/home_page.dart';
import 'package:cinequest/src/features/movie/presentation/pages/tickets_page.dart';
import 'package:cinequest/src/features/navigation/presentation/pages/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/setting/presentation/pages/setting_page.dart';
import 'route_enums.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final class RouterPages {
  RouterPages._();

  static final RouterPages _instance = RouterPages._();

  factory RouterPages() => _instance;

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash.path,
    redirect: _guard,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.splash.path,
        builder: (context, state) => const WelcomePage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const SplashPage(),
          fadeTransition: true,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.welcome.path,
        builder: (context, state) => const WelcomePage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const WelcomePage(),
          fadeTransition: true,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.login.path,
        builder: (context, state) => const LoginPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.signUp.path,
        builder: (context, state) => const SignUpPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const SignUpPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.accountSetup.path,
        builder: (context, state) => const AccountSetupPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const AccountSetupPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.resetPassword.path,
        builder: (context, state) => const ResetPasswordPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const ResetPasswordPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ticket.path,
                pageBuilder: PageTransitionUtil.customPageBuilder(
                  child: const TicketsPage(),
                  fadeTransition: true,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                pageBuilder: PageTransitionUtil.customPageBuilder(
                  child: const HomePage(),
                  fadeTransition: true,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile.path,
                pageBuilder: PageTransitionUtil.customPageBuilder(
                  child: const ProfilePage(),
                  fadeTransition: true,
                ),
              ),
            ],
          ),
        ],
        pageBuilder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell navigationShell) =>
            PageTransitionUtil.buildPageWithFadeTransition(
          context: context,
          state: state,
          child: NavigationPage(
            child: navigationShell,
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.setting.path,
        builder: (context, state) => const SettingPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const SettingPage(),
          direction: PageTransitionDirection.right,
        ),
      ),
    ],
  );

  static String _path = '';
  static void refeshPath() {
    _path = '';
  }

  static String? _guard(BuildContext context, GoRouterState state) {
    // Đọc trạng thái xác thực của app
    var appAuthState = context.read<AppAuthBloc>().state;

    // Cập nhật lại path sau mỗi lần điều hướng
    if (_path == '') {
      _path = state.uri.path;
    } else {
      _path += state.uri.path;
    }

    var isUnAuthenticated = appAuthState is AppUnAuthenticatedState;
    var isAuthenticated = appAuthState is AppAuthenticatedState;

    // Nếu đã đăng nhập mà path hiện tại chưa chứa path của home page
    // thì trả về path của home page
    if (isAuthenticated && !_path.contains(AppRoutes.home.path)) {
      return AppRoutes.home.path;
    }
    // Nếu chưa đăng nhập mà path hiện tại chưa chứa path của welcome page
    // thì trả về path của welcome page
    else if (isUnAuthenticated && !_path.contains(AppRoutes.welcome.path)) {
      return AppRoutes.welcome.path;
    }

    return null;
  }
}
