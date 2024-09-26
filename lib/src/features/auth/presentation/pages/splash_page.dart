import 'package:cinequest/gen/colors.gen.dart';
import 'package:flutter/material.dart';

/// Trang Splash
class SplashPage extends StatelessWidget {
  /// Constructor
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.white,
        ),
      ),
    );
  }
}
