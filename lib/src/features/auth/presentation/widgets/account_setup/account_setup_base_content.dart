import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/account_setup/account_setup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Base cho các process của AccountSetupPage
class AccountSetupBaseContent extends StatelessWidget {
  /// Constructor
  const AccountSetupBaseContent({
    required this.child,
    required this.onNext,
    required this.onBack,
    required this.isLoading,
    super.key,
  });

  ///
  final Widget child;

  ///
  final VoidCallback onNext;

  ///
  final VoidCallback onBack;

  ///
  final bool isLoading;

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
          appBar: AuthAppBar(
            title: 'Account Setup'.hardcoded,
            hasLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.defaultSpace,
              AppSizes.defaultSpace * 2,
              AppSizes.defaultSpace,
              AppSizes.defaultSpace / 2,
            ),
            child: child,
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.eerieBlack),
              ),
            ),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              height: 74,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CustomCircleButton(
                          iconPath: AppAssets.images.caretLeft.path,
                          onPressed: onBack,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '${state.currentPage + 1} '.hardcoded,
                        style: context.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: ' - 4'.toUpperCase().hardcoded,
                            style: context.textTheme.bodyMedium!
                                .copyWith(color: AppColors.dimGray),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Spacer(),
                        if (_getValid(state))
                          CustomButton(
                            width: 100,
                            iconPath: AppAssets.images.arrowRight.path,
                            colorFilter: const ColorFilter.mode(
                              AppColors.black,
                              BlendMode.srcIn,
                            ),
                            buttonType: ButtonType.elevated,
                            onPressed: onNext,
                            isLoading: isLoading,
                          )
                        else
                          CustomButton(
                            width: 100,
                            iconPath: AppAssets.images.arrowRight.path,
                            buttonType: ButtonType.outlined,
                            onPressed: onNext,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _getValid(AccountSetupState state) {
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
