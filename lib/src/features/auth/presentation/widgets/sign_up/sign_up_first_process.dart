import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// First process của SignUpPage: Nhập email, password và confirm password
class SignUpFirstProcess extends StatelessWidget {
  /// Constructor
  const SignUpFirstProcess({
    required this.signUpFormKey,
    required this.emailTextEditingController,
    required this.setPasswordTextEditingController,
    required this.confirmPasswordTextEditingController,
    required this.onNext,
    required this.isLoading,
    super.key,
  });

  ///
  final GlobalKey<FormState> signUpFormKey;

  ///
  final TextEditingController emailTextEditingController;

  ///
  final TextEditingController setPasswordTextEditingController;

  ///
  final TextEditingController? confirmPasswordTextEditingController;

  ///
  final VoidCallback onNext;

  ///
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(title: 'Sign Up'.hardcoded),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.defaultSpace,
          AppSizes.defaultSpace * 2,
          AppSizes.defaultSpace,
          AppSizes.defaultSpace / 2,
        ),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) =>
              previous.isSignUpFormValid != current.isSignUpFormValid,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AuthForm(
                  title: "Let's Get Started!".hardcoded,
                  formKey: signUpFormKey,
                  emailTextEditingController: emailTextEditingController,
                  onEmailChanged: (value) => context
                      .read<SignUpBloc>()
                      .add(SignUpEvent.emailChanged(value)),
                  setPasswordTextEditingController:
                      setPasswordTextEditingController,
                  onSetPasswordChanged: (value) => context
                      .read<SignUpBloc>()
                      .add(SignUpEvent.setPasswordChanged(value)),
                  confirmPasswordTextEditingController:
                      confirmPasswordTextEditingController,
                  onConfirmPasswordChanged: (value) => context
                      .read<SignUpBloc>()
                      .add(SignUpEvent.confirmPasswordChanged(value)),
                ),
                const Spacer(),
                if (state.isSignUpFormValid)
                  CustomButton(
                    width: 170,
                    iconPath: AppAssets.images.arrowRight.path,
                    colorFilter: const ColorFilter.mode(
                      AppColors.black,
                      BlendMode.srcIn,
                    ),
                    buttonType: ButtonType.elevated,
                    onPressed: onNext,
                    isLoading: isLoading,
                  )
                else
                  CustomButton(
                    width: 170,
                    iconPath: AppAssets.images.arrowRight.path,
                    buttonType: ButtonType.outlined,
                    onPressed: onNext,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
