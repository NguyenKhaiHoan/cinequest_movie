import 'package:cinequest/src/common/bloc/app/app_bloc.dart';
import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:cinequest/src/core/utils/page_transition_util.dart';
import 'package:cinequest/src/features/auth/presentation/pages/account_setup_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/login_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/splash_page.dart';
import 'package:cinequest/src/features/auth/presentation/pages/welcome_page.dart';
import 'package:cinequest/src/features/movie/presentation/pages/home_page.dart';
import 'package:cinequest/src/features/movie/presentation/pages/profile_page.dart';
import 'package:cinequest/src/features/movie/presentation/pages/tickets_page.dart';
import 'package:cinequest/src/features/navigation/presentation/pages/navigation_page.dart';
import 'package:cinequest/src/features/setting/presentation/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Quản lý tuyến đường trong App
final class RouterPages {
  /// Trả về instance duy nhất
  factory RouterPages() => _instance;
  RouterPages._();

  static final RouterPages _instance = RouterPages._();

  /// Khởi tạo router
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
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) =>
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

  ///
  static String _path = '';

  ///
  static String get path => _path;

  ///
  static void refreshPath() {
    _path = '';
  }

  static String? _guard(BuildContext context, GoRouterState state) {
    // Đọc trạng thái xác thực của app
    final appAuthState = context.read<AppBloc>().state;

    // Cập nhật lại path sau mỗi lần điều hướng
    if (_path == '') {
      _path = state.uri.path;
    } else {
      _path += state.uri.path;
    }

    // Nếu chưa setup account thì trả về AccountSetupPage trong trường hợp
    // mở lại ứng dụng khi mới đăng ký xong chưa kịp setup
    if (appAuthState == const AppState.accountNotSetup()) {
      print('Chưa setup');
      return _path += AppRoutes.accountSetup.path;
    }
    // Nếu đã đăng nhập mà path hiện tại chưa chứa path của HomePage
    // thì trả về path của home page
    else if (appAuthState.maybeWhen(
          authenticated: (value) => true,
          orElse: () => false,
        ) &&
        !_path.contains(AppRoutes.home.path)) {
      print('Đã xác thực');
      return AppRoutes.home.path;
    }
    // Nếu chưa đăng nhập mà path hiện tại chưa chứa path của WelcomePage
    // thì trả về path của welcome page
    else if (appAuthState == const AppState.unauthenticated() &&
        !_path.contains(AppRoutes.welcome.path)) {
      print('Chưa xác thực');
      return AppRoutes.welcome.path;
    }

    return null;
  }
}
