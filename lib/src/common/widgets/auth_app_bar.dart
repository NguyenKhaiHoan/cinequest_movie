import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/common/widgets/text_upper_case.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/colors.gen.dart';
import '../constants/app_sizes.dart';
import 'app_bar_bottom_divider.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  final VoidCallback? onBackTap;
  final double? appBarHeight;

  const AuthAppBar(
      {super.key,
      required this.title,
      this.onBackTap,
      this.hasLeading = true,
      this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBarBottomDivider(
      leadingWidth: 90,
      leading: hasLeading
          ? PaddingAppBar(
              isLeft: true,
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
        PaddingAppBar(
          isLeft: false,
          child: TextUpperCase(
            text: title,
            textColor: AppColors.dimGray,
          ),
        )
      ],
      appBarHeight: appBarHeight,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
