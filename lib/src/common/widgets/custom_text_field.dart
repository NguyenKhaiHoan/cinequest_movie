import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/core/extensions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../bloc/text_field/text_field_bloc.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final bool isVerificationCode;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool checkCharacterCounter;
  final int couter;

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.isVerificationCode = false,
    required this.controller,
    this.onChanged,
    this.validator,
    this.checkCharacterCounter = false,
    this.couter = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TextFieldBloc(),
      child: BlocBuilder<TextFieldBloc, TextFieldState>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            obscureText: isPassword ? state.obscureText : false,
            style: context.textTheme.bodyMedium,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              labelText: label.toUpperCase(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              counter: checkCharacterCounter
                  ? Text.rich(
                      TextSpan(
                        text: couter.toString(),
                        style: context.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: '/120',
                            style: context.textTheme.bodyMedium!
                                .copyWith(color: AppColors.dimGray),
                          ),
                        ],
                      ),
                    )
                  : null,
              suffixIcon: isPassword
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgIcon(
                        iconPath: state.obscureText
                            ? AppAssets.images.eyeSlash.path
                            : AppAssets.images.eye.path,
                        colorFilter: const ColorFilter.mode(
                            AppColors.raisinBlack, BlendMode.srcIn),
                        onPressed: () => context
                            .read<TextFieldBloc>()
                            .add(const TextFieldEvent.toggleVisibility()),
                      ),
                    )
                  : null,
            ),
            keyboardType:
                isVerificationCode ? TextInputType.number : TextInputType.text,
          );
        },
      ),
    );
  }
}
