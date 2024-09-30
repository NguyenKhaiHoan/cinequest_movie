import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/account_setup/account_setup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// View thêm profile photo
class ASProfilePhotoView extends StatelessWidget {
  /// Constructor
  const ASProfilePhotoView({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      buildWhen: (previous, current) =>
          previous.profilePhoto != current.profilePhoto,
      builder: (context, state) {
        return Column(
          children: [
            Text(
              title,
              style: context.textTheme.headlineMedium,
            ),
            gapH62,
            if (state.profilePhoto == null)
              CustomCircleButton(
                iconPath: AppAssets.images.plus.path,
                buttonSize: 150,
                colorFilter: const ColorFilter.mode(
                  AppColors.dimGray,
                  BlendMode.srcIn,
                ),
                onPressed: onPressed,
              )
            else
              InkWell(
                onTap: onPressed,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(state.profilePhoto!),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
