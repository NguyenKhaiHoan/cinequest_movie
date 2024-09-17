import 'package:cinequest/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final double? iconSize;
  final String iconPath;
  final bool notNeedColorFilter;
  final ColorFilter? colorFilter;
  final VoidCallback? onPressed;

  const SvgIcon({
    super.key,
    required this.iconPath,
    this.notNeedColorFilter = false,
    this.colorFilter,
    this.iconSize,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        iconPath,
        width: iconSize ?? 24,
        height: iconSize ?? 24,
        colorFilter: notNeedColorFilter
            ? null
            : colorFilter ??
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    );
  }
}
