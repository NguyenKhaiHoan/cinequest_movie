import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/constants/app_sizes.dart';
import '../../../../../common/widgets/custom_text_field.dart';
import '../../blocs/account_setup/account_setup_bloc.dart';

class AccountSetupThirdProcess extends StatelessWidget {
  final String title;
  final Function(String)? onChanged;

  final GlobalKey<FormState> formKey;

  final TextEditingController bioTextEditingController;

  const AccountSetupThirdProcess({
    super.key,
    required this.title,
    this.onChanged,
    required this.formKey,
    required this.bioTextEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.headlineMedium,
            ),
            gapH24,
            Form(
              key: formKey,
              child: CustomTextField(
                label: 'Bio'.hardcoded,
                controller: bioTextEditingController,
                onChanged: onChanged,
                checkCharacterCounter: true,
                couter: state.bio.length,
                validator: (value) =>
                    ValidationUtil.validateEmptyField('Bio', value),
              ),
            ),
          ],
        );
      },
    );
  }
}
