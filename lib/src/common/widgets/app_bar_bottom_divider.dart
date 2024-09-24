import 'package:flutter/material.dart';

import 'custom_divider.dart';

class AppBarBottomDivider extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final double? appBarHeight;

  const AppBarBottomDivider(
      {super.key,
      this.leadingWidth,
      this.appBarHeight,
      this.leading,
      this.actions,
      this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      leading: leading,
      actions: actions,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: CustomDivider(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 60);
}
