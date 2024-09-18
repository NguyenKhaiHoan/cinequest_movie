import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';
import '../constants/app_sizes.dart';
import 'svg_icon.dart';

class CustomCircleButton extends StatelessWidget {
  final String iconPath;
  final double? iconSize;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final ColorFilter? colorFilter;
  final bool notNeedColorFilter;

  const CustomCircleButton({
    super.key,
    this.iconSize,
    this.borderColor,
    this.onPressed,
    this.colorFilter,
    this.notNeedColorFilter = false,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: Container(
        height: AppSizes.buttonHeight,
        width: AppSizes.buttonHeight,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.raisinBlack)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgIcon(
            iconPath: iconPath,
            colorFilter: colorFilter,
            iconSize: iconSize,
            notNeedColorFilter: notNeedColorFilter,
          ),
        ),
      ),
    );
  }
}
