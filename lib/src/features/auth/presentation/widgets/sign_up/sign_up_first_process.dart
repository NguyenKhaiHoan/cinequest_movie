import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../common/constants/app_sizes.dart';
import '../../../../../common/widgets/custom_app_bar.dart';
import '../../../../../core/enums/button_type.dart';
import '../../blocs/sign_up_form/sign_up_form_bloc.dart';
import '../auth_form.dart';

class SignUpFirstProcess extends StatelessWidget {
  final GlobalKey<FormState> signUpFormKey;
  final TextEditingController emailTextEditingController;
  final TextEditingController setPasswordTextEditingController;
  final TextEditingController? confirmPasswordTextEditingController;
  final VoidCallback onNext;

  const SignUpFirstProcess({
    super.key,
    required this.signUpFormKey,
    required this.emailTextEditingController,
    required this.setPasswordTextEditingController,
    required this.confirmPasswordTextEditingController,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sign Up'.hardcoded),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 2,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: BlocBuilder<SignUpFormBloc, SignUpFormState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AuthForm(
                  title: 'Let\'s Get Started!'.hardcoded,
                  formKey: signUpFormKey,
                  emailTextEditingController: emailTextEditingController,
                  onEmailChanged: (value) => context
                      .read<SignUpFormBloc>()
                      .add(SignUpFormEvent.emailChanged(value)),
                  setPasswordTextEditingController:
                      setPasswordTextEditingController,
                  onSetPasswordChanged: (value) => context
                      .read<SignUpFormBloc>()
                      .add(SignUpFormEvent.setPasswordChanged(value)),
                  confirmPasswordTextEditingController:
                      confirmPasswordTextEditingController,
                  onConfirmPasswordChanged: (value) => context
                      .read<SignUpFormBloc>()
                      .add(SignUpFormEvent.confirmPasswordChanged(value)),
                ),
                const Spacer(),
                state.isFormValid
                    ? CustomButton(
                        width: 170,
                        iconPath: AppAssets.images.arrowRight.path,
                        colorFilter: const ColorFilter.mode(
                            AppColors.black, BlendMode.srcIn),
                        buttonType: ButtonType.elevated,
                        onPressed: onNext,
                      )
                    : CustomButton(
                        width: 170,
                        iconPath: AppAssets.images.arrowRight.path,
                        buttonType: ButtonType.outline,
                        onPressed: onNext,
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
