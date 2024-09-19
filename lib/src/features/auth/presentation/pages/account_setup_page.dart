import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/account_setup_base_content.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/account_setup_first_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/bottom_sheet_util.dart';
import '../blocs/account_setup/account_setup_bloc.dart';
import '../widgets/account_setup/account_setup_forth_process.dart';
import '../widgets/account_setup/account_setup_second_process.dart';
import '../widgets/account_setup/account_setup_third_process.dart';

part 'mixins/account_setup_page.mixin.dart';

class AccountSetupPage extends StatefulWidget {
  const AccountSetupPage({super.key});

  @override
  State<AccountSetupPage> createState() => _AccountSetupPageState();
}

class _AccountSetupPageState extends State<AccountSetupPage>
    with AccountSetupPageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountSetupBloc(),
      child: BlocBuilder<AccountSetupBloc, AccountSetupState>(
          buildWhen: (previous, current) =>
              previous.currentPage != current.currentPage ||
              previous.profilePhoto != current.profilePhoto ||
              previous.bio.trim() != current.bio.trim(),
          builder: (context, state) {
            return AccountSetupBaseContent(
              onNext: () => _next(state.currentPage),
              onBack: _back,
              child: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) => context
                    .read<AccountSetupBloc>()
                    .add(AccountSetupEvent.pageChanged(value)),
                children: [
                  AccountSetupFirstProcess(
                    title: 'Customize your account'.hardcoded,
                    subtitle:
                        'Your CineQuest Voice: Choose a Name to Share Your Reviews and Thoughts',
                    formKey: _usernameFormKey,
                    usernameTextEditingController:
                        _usernameTextEditingController,
                    onChanged: (value) => context
                        .read<AccountSetupBloc>()
                        .add(AccountSetupEvent.usernameChanged(value)),
                  ),
                  AccountSetupSecondProcess(
                    title: 'Customize your account'.hardcoded,
                    formKey: _fullNameCodeFormKey,
                    nameTextEditingController: _nameTextEditingController,
                    onNameChanged: (value) => context
                        .read<AccountSetupBloc>()
                        .add(AccountSetupEvent.nameChanged(value)),
                    surnameTextEditingController: _surnameTextEditingController,
                    onSurnameChanged: (value) => context
                        .read<AccountSetupBloc>()
                        .add(AccountSetupEvent.surnameChanged(value)),
                  ),
                  AccountSetupThirdProcess(
                    title: 'Share Your Story:\nCreate Your Bio'.hardcoded,
                    formKey: _bioFormKey,
                    bioTextEditingController: _bioTextEditingController,
                    onChanged: (value) => context
                        .read<AccountSetupBloc>()
                        .add(AccountSetupEvent.bioChanged(value)),
                    couter: state.bio.trim().length,
                  ),
                  AccountSetupForthProcess(
                    title: 'Snap a Selfie: Let\'s Put a Face to Your Name!',
                    profilePhoto: state.profilePhoto,
                    onPressed: () => _changePhoto(context),
                  )
                ],
              ),
            );
          }),
    );
  }
}
