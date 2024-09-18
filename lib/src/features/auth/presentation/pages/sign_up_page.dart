import 'package:cinequest/src/features/auth/presentation/blocs/sign_up_form/sign_up_form_bloc.dart';
import 'package:cinequest/src/core/enums/app_routes.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/sign_up/sign_up_first_process.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/sign_up/sign_up_second_process.dart';
// import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/verification_code_form/verification_code_form_bloc.dart';

part 'mixins/sign_up_page.mixin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignUpPageMixin {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        BlocProvider(
          create: (context) => SignUpFormBloc(),
          child: SignUpFirstProcess(
            signUpFormKey: _signUpFormKey,
            emailTextEditingController: _emailTextEditingController,
            setPasswordTextEditingController: _setPasswordTextEditingController,
            confirmPasswordTextEditingController:
                _confirmPasswordTextEditingController,
            onNext: _next,
          ),
        ),
        BlocProvider(
          create: (context) => VerificationCodeFormBloc(),
          child: SignUpSecondProcess(
            verificationCodeFormKey: _verificationCodeFormKey,
            email: _emailTextEditingController.text.trim(),
            verificationCodeTextEditingController:
                _verificationCodeTextEditingController,
            onBack: _back,
            onSignUp: () => _signUp(context),
          ),
        ),
      ],
    );
  }
}
