import 'package:cinequest/src/core/enums/app_routes.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../common/constants/app_sizes.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../core/enums/button_type.dart';

class BottomWelcome extends StatelessWidget {
  const BottomWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppSizes.defaultSpace,
        horizontal: AppSizes.defaultSpace,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(
            width: double.infinity,
            text: 'Get started'.hardcoded,
            textColor: AppColors.black,
            buttonType: ButtonType.elevated,
            onPressed: () => context.push(AppRoutes.signUp.path),
          ),
          gapH8,
          CustomButton(
            width: double.infinity,
            text: 'Login'.hardcoded,
            buttonType: ButtonType.outline,
            onPressed: () => context.push(AppRoutes.login.path),
          )
        ],
      ),
    );
  }
}
