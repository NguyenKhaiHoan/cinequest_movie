import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/reset_password/reset_password_first_process.dart';
import 'package:cinequest/src/features/auth/presentation/widgets/reset_password/reset_password_second_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/reset_password/reset_password_bloc.dart';

part 'mixins/reset_password_page.mixin.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with ResetPasswordPageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(),
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ResetPasswordFirstProcess(
            resetPasswordFormKey: _resetPasswordFormKey,
            emailTextEditingController: _emailTextEditingController,
            onSend: _send,
          ),
          BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            builder: (context, state) {
              return ResetPasswordSecondProcess(
                title: 'Check your Inbox'.hardcoded,
                subtitle:
                    'We have sent a link to ${state.email} with instructions to reset your password',
                email: state.email,
                onBack: _back,
                onResend: _resend,
              );
            },
          ),
        ],
      ),
    );
  }
}
