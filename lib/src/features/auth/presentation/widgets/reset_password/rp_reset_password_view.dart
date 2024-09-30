import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/reset_password/reset_password_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/forms/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// View nhập email
class RPResetPasswordView extends StatelessWidget {
  /// Constructor
  const RPResetPasswordView({
    required this.resetPasswordFormKey,
    required this.emailTextEditingController,
    required this.onSend,
    super.key,
    this.onEmailChanged,
  });
  final GlobalKey<FormState> resetPasswordFormKey;
  final TextEditingController emailTextEditingController;
  final void Function(String)? onEmailChanged;
  final void Function() onSend;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AuthAppBar(title: 'Reset Password'.hardcoded),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.defaultSpace,
              AppSizes.defaultSpace * 2,
              AppSizes.defaultSpace,
              AppSizes.defaultSpace / 2,
            ),
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
                  onEmailChanged: onEmailChanged,
                ),
                const Spacer(),
                if (state.isFormValided)
                  CustomButton(
                    width: 170,
                    iconPath: AppAssets.images.arrowRight.path,
                    colorFilter: const ColorFilter.mode(
                      AppColors.black,
                      BlendMode.srcIn,
                    ),
                    buttonType: ButtonType.elevated,
                    onPressed: onSend,
                  )
                else
                  CustomButton(
                    width: 170,
                    iconPath: AppAssets.images.arrowRight.path,
                    buttonType: ButtonType.outlined,
                    onPressed: onSend,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
