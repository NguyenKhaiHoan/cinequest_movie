import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

import '../../../../../common/constants/app_sizes.dart';
import '../../../../../common/widgets/custom_text_field.dart';

class AccountSetupThirdProcess extends StatelessWidget {
  final String title;
  final int couter;
  final Function(String)? onChanged;

  final GlobalKey<FormState> formKey;

  final TextEditingController bioTextEditingController;

  const AccountSetupThirdProcess({
    super.key,
    required this.title,
    this.onChanged,
    required this.formKey,
    required this.bioTextEditingController,
    required this.couter,
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
      ],
    );
  }

  Widget _buildCustomizeYourAccountForm() {
    return Form(
      key: formKey,
      child: CustomTextField(
        label: 'Bio'.hardcoded,
        controller: bioTextEditingController,
        onChanged: onChanged,
        checkCharacterCounter: true,
        couter: couter,
        validator: (value) => ValidationUtil.validateEmptyField('Bio', value),
      ),
    );
  }
}
