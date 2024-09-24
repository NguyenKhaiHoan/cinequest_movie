import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../common/constants/app_sizes.dart';
import '../../blocs/account_setup/account_setup_bloc.dart';

class AccountSetupForthProcess extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AccountSetupForthProcess({
    super.key,
    required this.title,
    required this.onPressed,
  });

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
            state.profilePhoto == null
                ? CustomCircleButton(
                    iconPath: AppAssets.images.plus.path,
                    buttonSize: 150,
                    iconSize: 24,
                    colorFilter: const ColorFilter.mode(
                        AppColors.dimGray, BlendMode.srcIn),
                    onPressed: onPressed,
                  )
                : InkWell(
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
                  )
          ],
        );
      },
    );
  }
}
