import 'package:cinequest/src/common/bloc/buttton/button_bloc.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/verification_code_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:cinequest/src/features/auth/domain/usecases/verificate_code_usecase.dart';
import 'package:cinequest/src/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/sign_up/sign_up_view.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/sign_up/verification_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '_mixins/sign_up_page.mixin.dart';

/// Trang SignUp
class SignUpPage extends StatelessWidget {
  /// Constructor
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
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
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SignUpView(
          listener: _listenerSignUp,
          formKey: _signUpFormKey,
          emailTextEditingController: _emailTextEditingController,
          setPasswordTextEditingController: _setPasswordTextEditingController,
          confirmPasswordTextEditingController:
              _confirmPasswordTextEditingController,
          onSignUp: _signUp,
          onEmailChanged: _changeEmail,
          onSetPasswordChanged: _changeSetPassword,
          onConfirmPasswordChanged: _changeConfirmPassword,
        ),
        VerificationCodeView(
          listener: _listenerVerificateCode,
          formKey: _verificationCodeFormKey,
          verificationCodeTextEditingController:
              _verificationCodeTextEditingController,
          onBack: _back,
          onCodeVerificated: _verificateCode,
          onVerificationCodeChanged: _changeVerificationCode,
        ),
      ],
    );
  }
}
