import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/route_enums.dart';

class PageTransitionUtil {
  PageTransitionUtil._();

  static Page<dynamic> Function(BuildContext, GoRouterState) customPageBuilder(
          {required Widget child,
          PageTransitionDirection direction = PageTransitionDirection.left,
          bool fadeTransition = false}) =>
      (BuildContext context, GoRouterState state) {
        return fadeTransition
            ? buildPageWithFadeTransition(
                context: context,
                state: state,
                child: child,
              )
            : buildPageWithDirectionTransition(
                context: context,
                state: state,
                child: child,
                direction: direction,
              );
      };

  static CustomTransitionPage buildPageWithFadeTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  static CustomTransitionPage buildPageWithDirectionTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    required PageTransitionDirection direction,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position:
            Tween<Offset>(begin: getBeginOffset(direction), end: Offset.zero)
                .animate(animation),
        child: child,
      ),
    );
  }

  static Offset getBeginOffset(PageTransitionDirection direction) {
    switch (direction) {
      case PageTransitionDirection.up:
        return const Offset(0, 1);
      case PageTransitionDirection.left:
        return const Offset(1, 0);
      case PageTransitionDirection.right:
        return const Offset(-1, 0);
      case PageTransitionDirection.down:
        return const Offset(0, -1);
    }
  }
}
