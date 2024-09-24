import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bottomNavLabelList = [
      'Tickets',
      'Home',
      'Profile',
    ];
    final bottomNavIconList = [
      AppAssets.images.ticket.path,
      AppAssets.images.house.path,
      AppAssets.images.user.path,
    ];

    return Container(
      height: 60,
      color: AppColors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultSpace / 2,
          vertical: AppSizes.defaultSpace / 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: currentIndex == index
                  ? Padding(
                      key: ValueKey('button_$index'),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CustomButton(
                        buttonType: ButtonType.elevated,
                        backgroundColor: AppColors.eerieBlack,
                        text: bottomNavLabelList[index],
                        iconPath: bottomNavIconList[index],
                        onPressed: () => onTap(index),
                      ),
                    )
                  : Padding(
                      key: ValueKey('circle_$index'),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CustomCircleButton(
                        iconPath: bottomNavIconList[index],
                        onPressed: () => onTap(index),
                      ),
                    ),
            );
          }),
        ),
      ),
    );
  }
}
