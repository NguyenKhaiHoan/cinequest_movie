import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/bloc/app/app_auth_bloc.dart';
import '../../../../common/bloc/buttton/button_bloc.dart';
import '../../../../common/constants/app_sizes.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../core/generics/usecase.dart';
import '../../../../core/injection_container.dart';
import '../../../auth/domain/usecases/sign_out_use_case.dart';

part 'mixins/setting_page.mixin.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with SettingPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH48,
            Text(
              'Settings',
              style: context.textTheme.headlineMedium,
            ),
            const Spacer(),
            BlocProvider(
              create: (context) => ButtonBloc(),
              child: BlocConsumer<ButtonBloc, ButtonState>(
                listener: _listener,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      buttonType: ButtonType.outline,
                      text: 'Log out'.toUpperCase().hardcoded,
                      isLoading: state is ButtonLoadingState,
                      onPressed: () => _signOut(context),
                    ),
                  );
                },
              ),
            ),
            gapH8,
          ],
        ),
      ),
    );
  }
}
