import 'package:flutter/material.dart';

import '../widgets/bottom_welcome.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BottomWelcome(),
        ],
      ),
    );
  }
}
