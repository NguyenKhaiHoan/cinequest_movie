import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/widgets/custom_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_divider.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../common/constants/app_sizes.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../core/enums/app_routes.dart';
import '../../../../core/enums/button_type.dart';
import '../widgets/auth_form.dart';

part 'mixins/login_page.mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: 'Login'.hardcoded),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 3,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: Column(
          children: [
            _buildMainLogin(),
            gapH24,
            const CustomDivider(),
            gapH16,
            Expanded(child: _buildBottomLogin())
          ],
        ),
      ),
    );
  }

  Widget _buildBottomLogin() {
    return Column(
      children: [
        CustomButton(
          isUpperCase: false,
          width: double.infinity,
          iconSize: 20,
          text: 'Sign in with Apple'.hardcoded,
          iconPath: AppAssets.images.apple.path,
          buttonType: ButtonType.outline,
        ),
        gapH8,
        CustomButton(
          isUpperCase: false,
          width: double.infinity,
          text: 'Sign in with Google'.hardcoded,
          iconPath: AppAssets.images.google.path,
          notNeedColorFilter: true,
          buttonType: ButtonType.outline,
        ),
        const Spacer(),
        TextButton(
          onPressed: () => context.push(AppRoutes.resetPassword.path),
          child: Text.rich(
            TextSpan(
              text: 'Don\'t have an account? '.hardcoded,
              style: context.textTheme.bodyMedium!
                  .copyWith(color: AppColors.raisinBlack),
              children: [
                TextSpan(
                  text: 'Sign up'.toUpperCase().hardcoded,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMainLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthForm(
          title: 'Welcome back'.hardcoded,
          formKey: _loginFormKey,
          emailTextEditingController: _emailTextEditingController,
          setPasswordTextEditingController: _setPasswordTextEditingController,
        ),
        gapH16,
        TextButton(
          onPressed: null,
          child: Text(
            'Forgot the password?'.hardcoded,
            style: context.textTheme.bodyMedium!
                .copyWith(color: AppColors.raisinBlack),
          ),
        ),
        gapH48,
        CustomButton(
          width: double.infinity,
          text: 'Login'.hardcoded,
          buttonType: ButtonType.outline,
          onPressed: () => _login(context),
        ),
      ],
    );
  }
}
