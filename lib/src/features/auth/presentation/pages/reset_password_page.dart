import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../common/constants/app_sizes.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../core/enums/button_type.dart';
import '../widgets/reset_password_form.dart';

part 'mixins/reset_password_page.mixin.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with ResetPasswordPageMixin {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        resetPasswordPage(),
        checkEmailPage(),
      ],
    );
  }

  Widget resetPasswordPage() {
    return Scaffold(
      appBar: CustomAppBar(title: 'Reset Password'.hardcoded),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 3,
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
              formKey: _resetPasswordFormKey,
              emailTextEditingController: _emailTextEditingController,
            ),
            const Spacer(),
            CustomButton(
              width: 170,
              iconPath: AppAssets.images.arrowRight.path,
              buttonType: ButtonType.outline,
              onPressed: () => _send(context),
            )
          ],
        ),
      ),
    );
  }

  Widget checkEmailPage() {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reset Password'.hardcoded,
        onBackTap: _back,
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 3,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            'Check your inbox',
          )
        ]),
      ),
    );
  }
}
