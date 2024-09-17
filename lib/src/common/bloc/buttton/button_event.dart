part of 'button_bloc.dart';

@freezed
class ButtonEvent with _$ButtonEvent {
  const factory ButtonEvent.execute(
      {dynamic params, required UseCase useCase}) = EventButtonExecute;
}
