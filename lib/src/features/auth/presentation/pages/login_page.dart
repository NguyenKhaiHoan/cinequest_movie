import 'package:cinequest/src/common/bloc/app/app_bloc.dart';
import 'package:cinequest/src/common/bloc/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/login_use_case.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_mixins/login_page.mixin.dart';

/// Trang Login
class LoginPage extends StatefulWidget {
  /// Constructor
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
                loginKey: _loginKey,
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
