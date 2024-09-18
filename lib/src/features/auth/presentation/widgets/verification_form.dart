import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/colors.gen.dart';

class VerificationForm extends StatelessWidget {
  final String title;
  final String subtitle;
  final String email;
  final GlobalKey<FormState> formKey;
  final TextEditingController verificationCodeTextEditingController;
  final Function(String)? onVerificationCodeChanged;

  const VerificationForm({
    super.key,
    required this.title,
    required this.subtitle,
    required this.email,
    required this.formKey,
    required this.verificationCodeTextEditingController,
    this.onVerificationCodeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headlineMedium,
        ),
        gapH16,
        Text.rich(
          TextSpan(
            text: subtitle,
            style: context.textTheme.bodyMedium!
                .copyWith(color: AppColors.dimGray),
            children: [
              TextSpan(
                text: email,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        gapH24,
        _buildVerificationForm(),
      ],
    );
  }

  Widget _buildVerificationForm() {
    return Form(
      key: formKey,
      child: CustomTextField(
        label: 'Verification Code'.hardcoded,
        controller: verificationCodeTextEditingController,
        onChanged: onVerificationCodeChanged,
        validator: (value) =>
            ValidationUtil.validateEmptyField('Verification Code', value),
      ),
    );
  }
}
