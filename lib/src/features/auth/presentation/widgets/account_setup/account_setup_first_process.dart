import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../common/constants/app_sizes.dart';

class AccountSetupFirstProcess extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function(String)? onChanged;

  final GlobalKey<FormState> formKey;

  final TextEditingController usernameTextEditingController;

  const AccountSetupFirstProcess({
    super.key,
    required this.title,
    required this.subtitle,
    this.onChanged,
    required this.formKey,
    required this.usernameTextEditingController,
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
        gapH24,
        _buildCustomizeYourAccountForm(),
        gapH16,
        Text(
          subtitle,
          style:
              context.textTheme.bodyMedium!.copyWith(color: AppColors.dimGray),
        ),
      ],
    );
  }

  Widget _buildCustomizeYourAccountForm() {
    return Form(
      key: formKey,
      child: CustomTextField(
        label: 'Username'.hardcoded,
        controller: usernameTextEditingController,
        onChanged: onChanged,
        validator: (value) =>
            ValidationUtil.validateEmptyField('Username', value),
      ),
    );
  }
}
