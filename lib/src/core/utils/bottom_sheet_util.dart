import 'dart:io';

import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_divider.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/app_util.dart';
import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class BottomSheetUtil {
  BottomSheetUtil._();

  static Future<File?> showTakeImageBottomSheet(BuildContext context) async {
    return await showModalBottomSheet<File?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.defaultSpace / 3),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusLg),
                    color: AppColors.eerieBlack),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () async {
                        File? photo = await AppUtil.pickImageFromCamera();
                        if (!context.mounted) return;
                        Navigator.pop(context, photo);
                      },
                      child: Text(
                        'Take a Photo'.hardcoded,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                    const CustomDivider(),
                    TextButton(
                      onPressed: () async {
                        File? photo = await AppUtil.pickImageFromGallery();
                        if (!context.mounted) return;
                        Navigator.pop(context, photo);
                      },
                      child: Text(
                        'Upload from Gallery'.hardcoded,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              gapH8,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusMd),
                    color: AppColors.eerieBlack),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel'.hardcoded,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
