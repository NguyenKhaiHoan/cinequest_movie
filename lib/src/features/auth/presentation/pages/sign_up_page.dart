import 'package:cinequest/src/features/auth/presentation/widgets/auth_form.dart';
import 'package:cinequest/src/common/widgets/custom_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/enums/app_routes.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/verification.dart';
// import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../common/constants/app_sizes.dart';
import '../../../../core/enums/button_type.dart';

part 'mixins/sign_up_page.mixin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignUpPageMixin {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        signUpPage(),
        verificationPage(),
      ],
    );
  }

  Widget signUpPage() {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sign Up'.hardcoded),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 3,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AuthForm(
              title: 'Let\'s Get Started!'.hardcoded,
              formKey: _signUpFormKey,
              emailTextEditingController: _emailTextEditingController,
              setPasswordTextEditingController:
                  _setPasswordTextEditingController,
              confirmPasswordTextEditingController:
                  _confirmPasswordTextEditingController,
              onChanged: (value) => _onChangedEmail(value),
            ),
            const Spacer(),
            CustomButton(
              width: 170,
              iconPath: AppAssets.images.arrowRight.path,
              buttonType: ButtonType.outline,
              onPressed: _next,
            )
          ],
        ),
      ),
    );
  }

  Widget verificationPage() {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Verification'.hardcoded,
        onBackTap: _back,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 3,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VerificationForm(
              title: 'Verify your email address'.hardcoded,
              subtitle: 'We have sent the verification code to '.hardcoded,
              email: _emailTextEditingController.text.trim(),
              formKey: _verificationCodeFormKey,
              verificationCodeTextEditingController:
                  _verificationCodeTextEditingController,
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomButton(
                  width: 100,
                  text: '0:59',
                  buttonType: ButtonType.outline,
                ),
                gapW8,
                Expanded(
                    child: CustomButton(
                  text: 'Continue'.hardcoded,
                  textColor: AppColors.black,
                  buttonType: ButtonType.elevated,
                  onPressed: () => _signUp(context),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
