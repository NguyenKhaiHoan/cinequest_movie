part of 'button_bloc.dart';

@freezed
class ButtonState with _$ButtonState {
  const factory ButtonState.initial() = ButtonInitialState;
  const factory ButtonState.loading() = ButtonLoadingState;
  const factory ButtonState.success() = ButtonSuccessState;
  const factory ButtonState.failure({required Failure failure}) =
      ButtonFailureState;
}
