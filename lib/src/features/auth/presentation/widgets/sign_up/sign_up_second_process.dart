import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/enums/button_type.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/verification_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../common/constants/app_sizes.dart';
import '../../../../../common/widgets/custom_app_bar.dart';
import '../../blocs/sign_up/sign_up_bloc.dart';

class SignUpSecondProcess extends StatelessWidget {
  final GlobalKey<FormState> verificationCodeFormKey;
  final String email;
  final TextEditingController verificationCodeTextEditingController;
  final VoidCallback onBack;
  final VoidCallback onSignUp;

  const SignUpSecondProcess({
    super.key,
    required this.verificationCodeFormKey,
    required this.email,
    required this.verificationCodeTextEditingController,
    required this.onBack,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Verification'.hardcoded,
        onBackTap: onBack,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 2,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                VerificationForm(
                  title: 'Verify your email address'.hardcoded,
                  subtitle: 'We have sent the verification code to '.hardcoded,
                  email: email,
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
                      buttonType: ButtonType.outline,
                    ),
                    gapW8,
                    Expanded(
                      child: state.isVerificationCodeFormValid
                          ? CustomButton(
                              text: 'Continue'.hardcoded,
                              textColor: AppColors.black,
                              buttonType: ButtonType.elevated,
                              onPressed: onSignUp,
                            )
                          : CustomButton(
                              text: 'Continue'.hardcoded,
                              buttonType: ButtonType.outline,
                              onPressed: onSignUp,
                            ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
