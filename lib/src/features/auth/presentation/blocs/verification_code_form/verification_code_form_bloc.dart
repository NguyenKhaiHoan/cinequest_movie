import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_code_form_event.dart';
part 'verification_code_form_state.dart';
part 'verification_code_form_bloc.freezed.dart';

class VerificationCodeFormBloc
    extends Bloc<VerificationCodeFormEvent, VerificationCodeFormState> {
  VerificationCodeFormBloc() : super(VerificationCodeFormState.initial()) {
    on<VerificationCodeFormEvent>((events, emit) async {
      events.map(
        verificationCodeChanged: (event) =>
            _onVerificationCodeChanged(event, emit),
      );
    });
  }

  void _onVerificationCodeChanged(EventVerificationCodeChanged event,
      Emitter<VerificationCodeFormState> emit) {
    emit(state.copyWith(
      verificationCode: event.verificationCode,
      isFormValid: _isFormValid(event.verificationCode),
    ));
  }

  bool _isFormValid(String verificationCode) {
    return verificationCode.isNotEmpty;
  }
}
