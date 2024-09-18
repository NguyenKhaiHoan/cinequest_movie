import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/widgets/custom_divider.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/common/widgets/text_upper_case.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/colors.gen.dart';
import '../constants/app_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  final VoidCallback? onBackTap;

  const CustomAppBar(
      {super.key, required this.title, this.onBackTap, this.hasLeading = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 90,
      leading: hasLeading
          ? Padding(
              padding: const EdgeInsets.only(left: AppSizes.defaultSpace),
              child: GestureDetector(
                onTap: onBackTap ?? () => context.pop(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgIcon(iconPath: AppAssets.images.arrowLeft.path),
                    gapW4,
                    TextUpperCase(
                      text: 'Back'.hardcoded,
                    ),
                  ],
                ),
              ),
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSizes.defaultSpace),
          child: TextUpperCase(
            text: title,
            textColor: AppColors.dimGray,
          ),
        )
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: CustomDivider(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
