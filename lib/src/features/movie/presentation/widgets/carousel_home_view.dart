import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../common/constants/app_sizes.dart';

class CarouselHomeView extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final Widget child;

  const CarouselHomeView({
    super.key,
    required this.title,
    this.titleStyle,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        gapH16,
        child,
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                subtitle!.toUpperCase(),
                style: context.textTheme.bodySmall!
                    .copyWith(color: AppColors.dimGray),
              ),
            ),
          Text(title, style: titleStyle),
        ],
      ),
    );
  }
}

class CarouselBox extends StatelessWidget {
  const CarouselBox({
    super.key,
    required this.maxHeight,
    required this.children,
  });

  final double maxHeight;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight, minHeight: maxHeight),
      child: CarouselView(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg)),
        itemExtent: 320,
        shrinkExtent: 200,
        reverse: true,
        children: children,
      ),
    );
  }
}
