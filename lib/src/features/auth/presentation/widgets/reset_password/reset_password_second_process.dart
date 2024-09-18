import 'package:cinequest/src/common/widgets/custom_app_bar.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../common/constants/app_sizes.dart';

class ResetPasswordSecondProcess extends StatelessWidget {
  final VoidCallback onBack;

  const ResetPasswordSecondProcess({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reset Password'.hardcoded,
        onBackTap: onBack,
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(
            AppSizes.defaultSpace,
            AppSizes.defaultSpace * 2,
            AppSizes.defaultSpace,
            AppSizes.defaultSpace / 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            'Check your inbox',
          )
        ]),
      ),
    );
  }
}
