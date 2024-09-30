import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

/// Form của ResetPasswordPage
class ResetPasswordForm extends StatelessWidget {
  /// Constructor
  const ResetPasswordForm({
    required this.title,
    required this.subtitle,
    required this.formKey,
    required this.emailTextEditingController,
    super.key,
    this.onEmailChanged,
  });

  final String title;
  final String subtitle;
  final void Function(String)? onEmailChanged;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headlineMedium,
        ),
        gapH24,
        _buildResetPasswordForm(),
        gapH16,
        Text(
          subtitle,
          style:
              context.textTheme.bodyMedium!.copyWith(color: AppColors.dimGray),
        ),
      ],
    );
  }

  Widget _buildResetPasswordForm() {
    return Form(
      key: formKey,
      child: CustomTextField(
        label: 'Email'.hardcoded,
        controller: emailTextEditingController,
        onChanged: onEmailChanged,
        validator: (value) =>
            ValidationUtil.validateEmail('Email'.hardcoded, value),
      ),
    );
  }
}
