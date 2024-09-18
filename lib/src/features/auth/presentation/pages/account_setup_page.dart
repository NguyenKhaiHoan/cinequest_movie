import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/account_setup_base_content.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/account_setup/account_setup_first_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: Builder(builder: (context) {
        return AccountSetupBaseContent(
            onNext: _next,
            onBack: _back,
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) => context
                  .read<AccountSetupBloc>()
                  .add(AccountSetupEvent.pageChanged(value)),
              children: const [
                AccountSetupFirstProcess(),
                AccountSetupSecondProcess(),
                AccountSetupThirdProcess(),
                AccountSetupForthProcess()
              ],
            ));
      }),
    );
  }
}
