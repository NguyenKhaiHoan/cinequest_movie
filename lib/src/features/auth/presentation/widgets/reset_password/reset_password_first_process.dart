import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/enums/button_type.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_app_bar.dart';
import '../reset_password_form.dart';

class ResetPasswordFirstProcess extends StatelessWidget {
  final GlobalKey<FormState> resetPasswordFormKey;
  final TextEditingController emailTextEditingController;
  final VoidCallback onSend;

  const ResetPasswordFirstProcess(
      {super.key,
      required this.resetPasswordFormKey,
      required this.emailTextEditingController,
      required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Reset Password'.hardcoded),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 2,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ResetPasswordForm(
              title: 'Reset password'.hardcoded,
              subtitle:
                  'Enter your email to receive a confirmation link and reset your password'
                      .hardcoded,
              formKey: resetPasswordFormKey,
              emailTextEditingController: emailTextEditingController,
            ),
            const Spacer(),
            CustomButton(
              width: 170,
              iconPath: AppAssets.images.arrowRight.path,
              buttonType: ButtonType.outline,
              onPressed: onSend,
            )
          ],
        ),
      ),
    );
  }
}
