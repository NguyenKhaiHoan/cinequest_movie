import 'package:cinequest/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final double iconSize;
  final String iconPath;
  final bool notNeedColorFilter;
  final ColorFilter? colorFilter;
  final VoidCallback? onPressed;

  const SvgIcon({
    super.key,
    required this.iconPath,
    this.notNeedColorFilter = false,
    this.colorFilter,
    this.iconSize = 24,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: SvgPicture.asset(
        iconPath,
        width: iconSize,
        height: iconSize,
        colorFilter: notNeedColorFilter
            ? null
            : colorFilter ??
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    );
  }
}
