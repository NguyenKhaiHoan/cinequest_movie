part of 'text_field_bloc.dart';

@freezed
class TextFieldState with _$TextFieldState {
  const factory TextFieldState.obscure({@Default(true) bool obscureText}) =
      _TextFieldObscureState;
}
