import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';
import '../constants/app_sizes.dart';
import 'svg_icon.dart';

enum ButtonType {
  outline,
  elevated,
}

class CustomButton extends StatelessWidget {
  final bool isUpperCase;
  final String? text;
  final double? width;
  final Color? textColor;
  final bool isLoading;
  final String? iconPath;
  final double iconSize;
  final Color backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final ColorFilter? colorFilter;
  final bool notNeedColorFilter;
  final ButtonType buttonType;

  const CustomButton({
    super.key,
    this.text,
    this.width,
    this.textColor,
    this.isLoading = false,
    this.iconPath,
    this.iconSize = 24,
    this.backgroundColor = AppColors.white,
    this.borderColor,
    this.onPressed,
    this.colorFilter,
    this.notNeedColorFilter = false,
    required this.buttonType,
    this.isUpperCase = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = buttonType == ButtonType.elevated
        ? ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            ),
            backgroundColor: backgroundColor,
          )
        : OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            ),
            side: BorderSide(
                width: 1.5, color: borderColor ?? AppColors.eerieBlack),
          );

    final constrainedWidth = width;

    return SizedBox(
      height: AppSizes.buttonHeight,
      width: constrainedWidth,
      child: buttonType == ButtonType.elevated
          ? ElevatedButton(
              style: buttonStyle,
              onPressed: onPressed ?? () {},
              child: _buildContent(context),
            )
          : OutlinedButton(
              style: buttonStyle,
              onPressed: onPressed,
              child: _buildContent(context),
            ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator(
        color: backgroundColor == AppColors.white
            ? AppColors.black
            : AppColors.white,
      );
    }

    final hasText = text != null && text!.isNotEmpty;
    final textWidget = hasText
        ? Text(
            isUpperCase ? text!.toUpperCase() : text!,
            textAlign: TextAlign.center,
            style: textColor != null
                ? context.textTheme.bodyMedium!.copyWith(color: textColor)
                : context.textTheme.bodyMedium!,
          )
        : const SizedBox.shrink();

    if (iconPath?.isEmpty ?? true) {
      return textWidget;
    } else if (!hasText) {
      return SvgIcon(
        iconPath: iconPath!,
        colorFilter: colorFilter,
        iconSize: iconSize,
        notNeedColorFilter: notNeedColorFilter,
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            iconPath: iconPath!,
            colorFilter: colorFilter,
            iconSize: iconSize,
            notNeedColorFilter: notNeedColorFilter,
          ),
          gapW4,
          textWidget,
        ],
      );
    }
  }
}
