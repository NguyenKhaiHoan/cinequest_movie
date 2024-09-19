import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../common/constants/app_sizes.dart';
import '../../../../../common/widgets/custom_app_bar.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../core/enums/button_type.dart';
import '../../blocs/account_setup/account_setup_bloc.dart';

class AccountSetupBaseContent extends StatelessWidget {
  final Widget child;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AccountSetupBaseContent(
      {super.key,
      required this.child,
      required this.onNext,
      required this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      buildWhen: (previous, current) =>
          previous.currentPage != current.currentPage ||
          previous.isFirstFormValid != current.isFirstFormValid ||
          previous.isSecondFormValid != current.isSecondFormValid ||
          previous.isThirdFormValid != current.isThirdFormValid ||
          previous.isProfilePhotoValid != current.isProfilePhotoValid,
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: 'Account Setup'.hardcoded,
            hasLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSizes.defaultSpace,
                AppSizes.defaultSpace * 2,
                AppSizes.defaultSpace,
                AppSizes.defaultSpace / 2),
            child: child,
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.raisinBlack),
              ),
            ),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              height: 74,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        CustomCircleButton(
                          iconPath: AppAssets.images.caretLeft.path,
                          iconSize: 24,
                          onPressed: onBack,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: '${state.currentPage + 1} '.hardcoded,
                          style: context.textTheme.bodyMedium!,
                          children: [
                            TextSpan(
                              text: ' - 4'.toUpperCase().hardcoded,
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.dimGray),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        const Spacer(),
                        getValid(state)
                            ? CustomButton(
                                width: 100,
                                iconPath: AppAssets.images.arrowRight.path,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.black, BlendMode.srcIn),
                                buttonType: ButtonType.elevated,
                                onPressed: onNext,
                              )
                            : CustomButton(
                                width: 100,
                                iconPath: AppAssets.images.arrowRight.path,
                                buttonType: ButtonType.outline,
                                onPressed: onNext,
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool getValid(AccountSetupState state) {
    switch (state.currentPage) {
      case 0:
        return state.isFirstFormValid;
      case 1:
        return state.isSecondFormValid;
      case 2:
        return state.isThirdFormValid;
      case 3:
        return state.isProfilePhotoValid;
      default:
        return false;
    }
  }
}
