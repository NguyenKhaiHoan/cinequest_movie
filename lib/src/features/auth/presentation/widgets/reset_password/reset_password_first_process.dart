import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/reset_password/reset_password_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// First process của ResetPasswordPage: Nhập email
class ResetPasswordFirstProcess extends StatelessWidget {
  /// Constructor
  const ResetPasswordFirstProcess({
    required this.resetPasswordFormKey,
    required this.emailTextEditingController,
    required this.onSend,
    super.key,
  });
  final GlobalKey<FormState> resetPasswordFormKey;
  final TextEditingController emailTextEditingController;
  final VoidCallback onSend;

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
                  onChanged: (value) => context
                      .read<ResetPasswordBloc>()
                      .add(ResetPasswordEvent.emailChanged(value)),
                ),
                const Spacer(),
                if (state.isFormValid)
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
