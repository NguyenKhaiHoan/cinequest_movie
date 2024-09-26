import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

/// Second process của AccountSetUpPage: Nhập name và surname
class AccountSetupSecondProcess extends StatelessWidget {
  /// Constructor
  const AccountSetupSecondProcess({
    required this.title,
    required this.formKey,
    required this.nameTextEditingController,
    required this.surnameTextEditingController,
    super.key,
    this.onNameChanged,
    this.onSurnameChanged,
  });

  ///
  final String title;

  ///
  final void Function(String)? onNameChanged;

  ///
  final void Function(String)? onSurnameChanged;

  ///
  final GlobalKey<FormState> formKey;

  ///
  final TextEditingController nameTextEditingController;

  ///
  final TextEditingController surnameTextEditingController;

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
          ),
        ],
      ),
    );
  }
}
