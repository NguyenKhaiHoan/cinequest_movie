import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/verification_code_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:cinequest/src/features/auth/domain/usecases/verificate_code_use_case.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/sign_up/sign_up_first_process.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/sign_up/sign_up_second_process.dart';
// import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/bloc/buttton/button_bloc.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/routes/route_enums.dart';

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
          BlocProvider(
            create: (context) => ButtonBloc(),
            child: BlocConsumer<ButtonBloc, ButtonState>(
              listener: _listenerSignUp,
              builder: (context, state) {
                return SignUpFirstProcess(
                  signUpFormKey: _signUpFormKey,
                  emailTextEditingController: _emailTextEditingController,
                  setPasswordTextEditingController:
                      _setPasswordTextEditingController,
                  confirmPasswordTextEditingController:
                      _confirmPasswordTextEditingController,
                  onNext: () => _signUp(context),
                  isLoading: state is ButtonLoadingState,
                );
              },
            ),
          ),
          BlocProvider(
            create: (context) => ButtonBloc(),
            child: BlocConsumer<ButtonBloc, ButtonState>(
              listener: _listenerVerificateCode,
              builder: (context, state) {
                return SignUpSecondProcess(
                  verificationCodeFormKey: _verificationCodeFormKey,
                  verificationCodeTextEditingController:
                      _verificationCodeTextEditingController,
                  onBack: _back,
                  onSignUp: () => _verificateCode(context),
                  isLoading: state is ButtonLoadingState,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
