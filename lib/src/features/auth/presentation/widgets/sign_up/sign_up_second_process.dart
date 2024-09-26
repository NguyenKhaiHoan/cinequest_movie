import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/verification_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Second process của SignUpPage: Nhập verification code
class SignUpSecondProcess extends StatelessWidget {
  /// Constructor
  const SignUpSecondProcess({
    required this.verificationCodeFormKey,
    required this.verificationCodeTextEditingController,
    required this.onBack,
    required this.onSignUp,
    required this.isLoading,
    super.key,
  });

  ///
  final GlobalKey<FormState> verificationCodeFormKey;

  ///
  final TextEditingController verificationCodeTextEditingController;

  ///
  final VoidCallback onBack;

  ///
  final VoidCallback onSignUp;

  ///
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
        title: 'Verification'.hardcoded,
        onBackTap: onBack,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.defaultSpace,
          AppSizes.defaultSpace * 2,
          AppSizes.defaultSpace,
          AppSizes.defaultSpace / 2,
        ),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                VerificationForm(
                  title: 'Verify your email address'.hardcoded,
                  subtitle: 'We have sent the verification code to '.hardcoded,
                  email: state.email,
                  formKey: verificationCodeFormKey,
                  verificationCodeTextEditingController:
                      verificationCodeTextEditingController,
                  onVerificationCodeChanged: (value) => context
                      .read<SignUpBloc>()
                      .add(SignUpEvent.verificationCodeChanged(value)),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomButton(
                      width: 100,
                      text: '0:59',
                      buttonType: ButtonType.outlined,
                    ),
                    gapW8,
                    Expanded(
                      child: state.isVerificationCodeFormValid
                          ? CustomButton(
                              text: 'Continue'.hardcoded,
                              textColor: AppColors.black,
                              buttonType: ButtonType.elevated,
                              onPressed: onSignUp,
                              isLoading: isLoading,
                            )
                          : CustomButton(
                              text: 'Continue'.hardcoded,
                              buttonType: ButtonType.outlined,
                              onPressed: onSignUp,
                            ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
