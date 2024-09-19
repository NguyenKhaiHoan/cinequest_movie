import 'dart:io';

import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../common/constants/app_sizes.dart';

class AccountSetupForthProcess extends StatelessWidget {
  final String title;
  final File? profilePhoto;
  final VoidCallback onPressed;

  const AccountSetupForthProcess({
    super.key,
    required this.title,
    this.profilePhoto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.textTheme.headlineMedium,
        ),
        gapH62,
        profilePhoto == null
            ? CustomCircleButton(
                iconPath: AppAssets.images.plus.path,
                buttonSize: 150,
                iconSize: 24,
                colorFilter:
                    const ColorFilter.mode(AppColors.dimGray, BlendMode.srcIn),
                onPressed: onPressed,
              )
            : Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: FileImage(profilePhoto!),
                  ),
                ),
              )
      ],
    );
  }
}
