import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';
import '../constants/app_sizes.dart';

class CustomDivider extends StatelessWidget {
  final String? text;

  const CustomDivider({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Row(children: [
            Expanded(child: _buildDivider()),
            gapW16,
            Text(" $text "),
            gapW16,
            Expanded(child: _buildDivider()),
          ])
        : const Divider();
  }

  Widget _buildDivider() => const Divider(
        height: 0,
        color: AppColors.eerieBlack,
      );
}
