import 'package:cinequest/src/features/auth/presentation/widgets/reset_password/reset_password_first_process.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/reset_password/reset_password_second_process.dart';
import 'package:flutter/material.dart';

part 'mixins/reset_password_page.mixin.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with ResetPasswordPageMixin {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ResetPasswordFirstProcess(
          resetPasswordFormKey: _resetPasswordFormKey,
          emailTextEditingController: _emailTextEditingController,
          onSend: () => _send(),
        ),
        ResetPasswordSecondProcess(onBack: _back),
      ],
    );
  }
}
