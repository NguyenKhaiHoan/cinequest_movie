import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

/// View nhập username
class ASUsernameView extends StatelessWidget {
  /// Constructor
  const ASUsernameView({
    required this.title,
    required this.subtitle,
    required this.formKey,
    required this.usernameTextEditingController,
    super.key,
    this.onUsernameChanged,
  });

  final String title;
  final String subtitle;
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameTextEditingController;
  final void Function(String)? onUsernameChanged;

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
        onChanged: onUsernameChanged,
        validator: (value) =>
            ValidationUtil.validateEmptyField('Username'.hardcoded, value),
      ),
    );
  }
}
