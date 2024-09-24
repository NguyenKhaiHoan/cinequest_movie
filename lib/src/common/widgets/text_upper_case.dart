import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TextUpperCase extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? textColor;

  const TextUpperCase(
      {super.key, required this.text, this.textStyle, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: textStyle ??
          (textColor != null
              ? context.textTheme.bodyMedium!.copyWith(color: textColor)
              : context.textTheme.bodyMedium!),
    );
  }
}
