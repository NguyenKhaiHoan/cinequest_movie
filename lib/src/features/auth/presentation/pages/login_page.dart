import 'package:cinequest/src/common/bloc/app/app_bloc.dart';
import 'package:cinequest/src/common/bloc/buttton/button_bloc.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/features/auth/domain/usecases/get_email_password_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/save_email_password_usecase.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_mixins/login_page.mixin.dart';

/// Trang Login
class LoginPage extends StatelessWidget {
  /// Constructor
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
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
    return BlocListener<ButtonBloc, ButtonState>(
      listener: _listener,
      child: LoginView(
        formKey: _loginFormKey,
        emailTextEditingController: _emailTextEditingController,
        setPasswordTextEditingController: _setPasswordTextEditingController,
        onLogin: _login,
        onEmailChanged: _changeEmail,
        onSetPasswordChanged: _changeSetPassword,
      ),
    );
  }
}
