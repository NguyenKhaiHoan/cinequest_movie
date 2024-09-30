import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/bloc/app/app_bloc.dart';
import 'package:cinequest/src/common/bloc/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/bottom_sheet_util.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/save_profile_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/save_profile_use_case.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/account_setup/account_setup_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/as_bio_view.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/as_fullname_view.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/as_profile_photo_view.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/as_username_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part '_mixins/account_setup_page.mixin.dart';

/// Trang AccountSetupPage
class AccountSetupPage extends StatelessWidget {
  /// Constructor
  const AccountSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AccountSetupBloc(),
        ),
        BlocProvider(
          create: (context) => ButtonBloc(),
        ),
      ],
      child: const _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with _PageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      buildWhen: (previous, current) =>
          previous.currentPage != current.currentPage,
      builder: (context, state) {
        final profilePhoto = state.profilePhoto?.path;
        return BlocConsumer<ButtonBloc, ButtonState>(
          listener: _listener,
          builder: (context, state) {
            return _AccountSetupView(
              onNext: () => _next(profilePhoto),
              onBack: _back,
              isLoading: state == const ButtonState.loading(),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _changePage,
                children: [
                  ASUsernameView(
                    title: 'Customize your account'.hardcoded,
                    subtitle:
                        'Your CineQuest Voice: Choose a Name to Share Your Reviews and Thoughts'
                            .hardcoded,
                    formKey: _usernameFormKey,
                    usernameTextEditingController:
                        _usernameTextEditingController,
                    onUsernameChanged: _changeUsername,
                  ),
                  ASFullnameView(
                    title: 'Customize your account'.hardcoded,
                    formKey: _fullNameCodeFormKey,
                    nameTextEditingController: _nameTextEditingController,
                    onNameChanged: (value) => context
                        .read<AccountSetupBloc>()
                        .add(AccountSetupEvent.nameChanged(name: value)),
                    surnameTextEditingController: _surnameTextEditingController,
                    onSurnameChanged: _changeSurname,
                  ),
                  ASBioView(
                    title: 'Share Your Story:\nCreate Your Bio'.hardcoded,
                    formKey: _bioFormKey,
                    bioTextEditingController: _bioTextEditingController,
                    onChanged: _changeBio,
                  ),
                  ASProfilePhotoView(
                    title: "Snap a Selfie: Let's Put a Face to Your Name!"
                        .hardcoded,
                    onPressed: _changePhoto,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

/// View chung trong AccountSetup
class _AccountSetupView extends StatelessWidget {
  /// Constructor
  const _AccountSetupView({
    required this.child,
    required this.onNext,
    required this.onBack,
    required this.isLoading,
  });

  final Widget child;
  final void Function() onNext;
  final void Function() onBack;
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
