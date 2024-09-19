import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> formKey;

  final TextEditingController emailTextEditingController;
  final Function(String)? onEmailChanged;
  final TextEditingController setPasswordTextEditingController;
  final Function(String)? onSetPasswordChanged;
  final TextEditingController? confirmPasswordTextEditingController;
  final Function(String)? onConfirmPasswordChanged;

  const AuthForm({
    super.key,
    required this.title,
    required this.formKey,
    required this.emailTextEditingController,
    this.onEmailChanged,
    required this.setPasswordTextEditingController,
    this.onSetPasswordChanged,
    this.confirmPasswordTextEditingController,
    this.onConfirmPasswordChanged,
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
            label: 'Email'.hardcoded,
            controller: emailTextEditingController,
            onChanged: onEmailChanged,
            validator: (value) =>
                ValidationUtil.validateEmail('Email'.hardcoded, value),
          ),
          gapH16,
          CustomTextField(
            isPassword: true,
            label: 'Set Password'.hardcoded,
            controller: setPasswordTextEditingController,
            onChanged: onSetPasswordChanged,
            validator: (value) => ValidationUtil.validatePassword(
                'Set Password'.hardcoded, value),
          ),
          if (isSignUp) gapH16,
          if (isSignUp)
            CustomTextField(
              isPassword: true,
              label: 'Confirm Password'.hardcoded,
              controller: confirmPasswordTextEditingController!,
              onChanged: onConfirmPasswordChanged,
              validator: (value) => ValidationUtil.validateCorrectPassword(
                  'Confirm Password'.hardcoded,
                  value,
                  setPasswordTextEditingController.text),
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
