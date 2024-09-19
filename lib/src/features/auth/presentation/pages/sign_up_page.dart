import 'package:cinequest/src/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:cinequest/src/core/enums/app_routes.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/sign_up/sign_up_first_process.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/sign_up/sign_up_second_process.dart';
// import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'mixins/sign_up_page.mixin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignUpPageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SignUpFirstProcess(
            signUpFormKey: _signUpFormKey,
            emailTextEditingController: _emailTextEditingController,
            setPasswordTextEditingController: _setPasswordTextEditingController,
            confirmPasswordTextEditingController:
                _confirmPasswordTextEditingController,
            onNext: _next,
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return SignUpSecondProcess(
                verificationCodeFormKey: _verificationCodeFormKey,
                email: state.email,
                verificationCodeTextEditingController:
                    _verificationCodeTextEditingController,
                onBack: _back,
                onSignUp: () => _signUp(),
              );
            },
          ),
        ],
      ),
    );
  }
}
