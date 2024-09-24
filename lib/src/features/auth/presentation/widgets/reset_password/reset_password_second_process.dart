import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../common/constants/app_sizes.dart';
import '../../../../../common/widgets/custom_button.dart';

class ResetPasswordSecondProcess extends StatelessWidget {
  final String title;
  final String subtitle;
  final String email;
  final VoidCallback onBack;
  final VoidCallback onResend;

  const ResetPasswordSecondProcess({
    super.key,
    required this.title,
    required this.subtitle,
    required this.email,
    required this.onBack,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    List<String> parts = subtitle.split(email);
    String part1 = parts[0];
    String part2 = parts[1];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AuthAppBar(
        title: 'Reset Password'.hardcoded,
        onBackTap: onBack,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 2,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.headlineMedium,
            ),
            gapH16,
            Text.rich(
              TextSpan(
                text: '$part1\n',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: AppColors.dimGray),
                children: [
                  TextSpan(
                    text: '$email\n',
                    style: context.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: part2,
                  ),
                ],
              ),
            ),
            gapH48,
            SizedBox(
              width: double.infinity,
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.images.sendEmail.path,
                  width: UiUtil.deviceWidth * 0.7,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              width: double.infinity,
              text: 'Resend email'.hardcoded,
              textColor: AppColors.black,
              buttonType: ButtonType.elevated,
              onPressed: onResend,
            )
          ],
        ),
      ),
    );
  }
}
