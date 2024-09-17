import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final Function(String)? onChanged;

  final TextEditingController emailTextEditingController;
  final TextEditingController setPasswordTextEditingController;
  final TextEditingController? confirmPasswordTextEditingController;

  const AuthForm({
    super.key,
    required this.title,
    required this.formKey,
    this.onChanged,
    required this.emailTextEditingController,
    required this.setPasswordTextEditingController,
    this.confirmPasswordTextEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        gapH24,
        _buildAuthForm(),
      ],
    );
  }

  Widget _buildAuthForm() {
    final isSignUp = confirmPasswordTextEditingController != null;
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Email',
            controller: emailTextEditingController,
            onChanged: onChanged,
          ),
          gapH16,
          CustomTextField(
            isPassword: true,
            label: 'Set Password',
            controller: setPasswordTextEditingController,
          ),
          if (isSignUp) gapH16,
          if (isSignUp)
            CustomTextField(
              isPassword: true,
              label: 'Confirm Password',
              controller: confirmPasswordTextEditingController!,
            ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.headlineMedium,
    );
  }
}
