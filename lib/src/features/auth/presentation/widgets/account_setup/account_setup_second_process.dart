import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

import '../../../../../common/constants/app_sizes.dart';
import '../../../../../common/widgets/custom_text_field.dart';

class AccountSetupSecondProcess extends StatelessWidget {
  final String title;
  final Function(String)? onNameChanged;
  final Function(String)? onSurnameChanged;

  final GlobalKey<FormState> formKey;

  final TextEditingController nameTextEditingController;
  final TextEditingController surnameTextEditingController;

  const AccountSetupSecondProcess({
    super.key,
    required this.title,
    this.onNameChanged,
    this.onSurnameChanged,
    required this.formKey,
    required this.nameTextEditingController,
    required this.surnameTextEditingController,
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
      child: Column(
        children: [
          CustomTextField(
            label: 'Name'.hardcoded,
            controller: nameTextEditingController,
            onChanged: onNameChanged,
            validator: (value) =>
                ValidationUtil.validateEmptyField('Name', value),
          ),
          gapH16,
          CustomTextField(
            label: 'Surname'.hardcoded,
            controller: surnameTextEditingController,
            onChanged: onSurnameChanged,
            validator: (value) =>
                ValidationUtil.validateEmptyField('Surname', value),
          )
        ],
      ),
    );
  }
}
