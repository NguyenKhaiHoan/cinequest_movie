import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Carousel chung cho trang Home
class CarouselHomeView extends StatelessWidget {
  /// Constructor
  const CarouselHomeView({
    required this.title,
    required this.child,
    super.key,
    this.titleStyle,
    this.subtitle,
  });

  final String title;

  final TextStyle? titleStyle;

  final String? subtitle;

  final Widget child;

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

/// Carousel box
class CarouselBox extends StatelessWidget {
  /// Constructor
  const CarouselBox({
    required this.maxHeight,
    required this.children,
    super.key,
  });

  final double maxHeight;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight, minHeight: maxHeight),
      child: CarouselSlider(
        options: CarouselOptions(
          height: maxHeight,
          enlargeCenterPage: true,
          autoPlay: true,
          disableCenter: true,
        ),
        items: children,
      ),
    );
  }
}
