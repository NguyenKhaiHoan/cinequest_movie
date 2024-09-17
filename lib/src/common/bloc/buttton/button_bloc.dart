import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';

part 'button_bloc.freezed.dart';
part 'button_event.dart';
part 'button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(const ButtonState.initial()) {
    on<ButtonEvent>((events, emit) async {
      await events.map(
        execute: (event) async => await onExecute(event, emit,
            params: event.params, useCase: event.useCase),
      );
    });
  }

  Future<void> onExecute(EventButtonExecute event, Emitter<ButtonState> emit,
      {dynamic params, required UseCase useCase}) async {
    emit(const ButtonState.loading());
    try {
      var result = await useCase.call(params: params);

      result.fold((failure) {
        emit(ButtonState.failure(failure: failure));
      }, (data) {
        emit(const ButtonState.success());
      });
    } catch (e) {
      emit(
        ButtonState.failure(failure: Failure(message: e.toString())),
      );
    }
  }
}
