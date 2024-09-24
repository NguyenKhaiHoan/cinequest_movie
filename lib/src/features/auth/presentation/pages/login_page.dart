import 'package:cinequest/src/common/bloc/app/app_auth_bloc.dart';
import 'package:cinequest/src/common/bloc/buttton/button_bloc.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/login_use_case.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/app_sizes.dart';
import '../../../../core/injection_container.dart';
import '../blocs/login/login_bloc.dart';

part 'mixins/login_page.mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(title: 'Login'.hardcoded),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.defaultSpace,
          AppSizes.defaultSpace * 2,
          AppSizes.defaultSpace,
          AppSizes.defaultSpace / 2,
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(),
            ),
            BlocProvider(
              create: (context) => ButtonBloc(),
            ),
          ],
          child: BlocConsumer<ButtonBloc, ButtonState>(
            listener: _listener,
            builder: (context, state) {
              return LoginBody(
                LoginKey: _LoginKey,
                emailTextEditingController: _emailTextEditingController,
                setPasswordTextEditingController:
                    _setPasswordTextEditingController,
                onLogin: () => _login(context),
                isLoading: state is ButtonLoadingState,
              );
            },
          ),
        ),
      ),
    );
  }
}
