import 'package:cinequest/src/common/widgets/custom_app_bar.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants/app_sizes.dart';
import '../../../../core/enums/app_routes.dart';
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
      appBar: CustomAppBar(title: 'Login'.hardcoded),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.defaultSpace,
          AppSizes.defaultSpace * 2,
          AppSizes.defaultSpace,
          AppSizes.defaultSpace / 2,
        ),
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: LoginBody(
            loginFormKey: _loginFormKey,
            emailTextEditingController: _emailTextEditingController,
            setPasswordTextEditingController: _setPasswordTextEditingController,
            onLogin: () => _login(),
          ),
        ),
      ),
    );
  }
}
