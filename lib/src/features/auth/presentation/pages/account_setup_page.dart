import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/save_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cinequest/src/features/auth/domain/usecases/save_profile_user_use_case.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/account_setup_base_content.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/account_setup_first_process.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/bloc/buttton/button_bloc.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/routes/route_enums.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AccountSetupBloc(),
        ),
        BlocProvider(
          create: (context) => ButtonBloc(),
        ),
      ],
      child: BlocBuilder<AccountSetupBloc, AccountSetupState>(
          buildWhen: (previous, current) =>
              previous.currentPage != current.currentPage ||
              previous.profilePhoto != current.profilePhoto,
          builder: (context, state) {
            var currentPage = state.currentPage;
            var profilePhoto = state.profilePhoto?.path;
            return BlocConsumer<ButtonBloc, ButtonState>(
              listener: _listener,
              builder: (context, state) {
                return AccountSetupBaseContent(
                  onNext: () => _next(context, currentPage, profilePhoto),
                  onBack: _back,
                  isLoading: state is ButtonLoadingState,
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
                        surnameTextEditingController:
                            _surnameTextEditingController,
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
                      ),
                      AccountSetupForthProcess(
                        title: 'Snap a Selfie: Let\'s Put a Face to Your Name!',
                        onPressed: () => _changePhoto(context),
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
