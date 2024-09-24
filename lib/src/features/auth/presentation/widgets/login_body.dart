import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../common/constants/app_sizes.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_divider.dart';
import '../../../../core/routes/route_enums.dart';
import 'auth_form.dart';

class LoginBody extends StatelessWidget {
  final GlobalKey<FormState> LoginKey;
  final TextEditingController emailTextEditingController;
  final TextEditingController setPasswordTextEditingController;
  final VoidCallback onLogin;
  final bool isLoading;

  const LoginBody({
    super.key,
    required this.LoginKey,
    required this.emailTextEditingController,
    required this.setPasswordTextEditingController,
    required this.onLogin,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.isFormValid != current.isFormValid,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthForm(
              title: 'Welcome back'.hardcoded,
              formKey: LoginKey,
              emailTextEditingController: emailTextEditingController,
              onEmailChanged: (value) =>
                  context.read<LoginBloc>().add(LoginEvent.emailChanged(value)),
              setPasswordTextEditingController:
                  setPasswordTextEditingController,
              onSetPasswordChanged: (value) => context
                  .read<LoginBloc>()
                  .add(LoginEvent.setPasswordChanged(value)),
            ),
            gapH16,
            TextButton(
              onPressed: () => context.push(AppRoutes.resetPassword.path),
              child: Text(
                'Forgot the password?'.hardcoded,
                style: context.textTheme.bodyMedium!
                    .copyWith(color: AppColors.dimGray),
              ),
            ),
            gapH48,
            state.isFormValid
                ? CustomButton(
                    width: double.infinity,
                    text: 'Login'.hardcoded,
                    textColor: AppColors.black,
                    buttonType: ButtonType.elevated,
                    onPressed: onLogin,
                    isLoading: isLoading,
                  )
                : CustomButton(
                    width: double.infinity,
                    text: 'Login'.hardcoded,
                    buttonType: ButtonType.outline,
                    onPressed: onLogin,
                  ),
            gapH24,
            const CustomDivider(),
            gapH16,
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
            gapH62,
            SizedBox(
              width: double.infinity,
              child: Center(
                child: TextButton(
                  onPressed: () => context.push(AppRoutes.signUp.path),
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account? '.hardcoded,
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: AppColors.dimGray),
                      children: [
                        TextSpan(
                          text: 'Sign up'.toUpperCase().hardcoded,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
