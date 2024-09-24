import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../../../core/generics/usecase.dart';

part 'button_bloc.freezed.dart';
part 'button_event.dart';
part 'button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(const ButtonState.initial()) {
    on<ButtonEvent>((events, emit) async {
      await events.map(
        execute: (event) async => await _onExecute(event, emit,
            params: event.params, useCase: event.useCase),
      );
    });
  }

  Future<void> _onExecute(EventButtonExecute event, Emitter<ButtonState> emit,
      {dynamic params, required UseCase useCase}) async {
    emit(const ButtonState.loading());
    var result = await useCase.call(params: params);

    result.fold((failure) {
      emit(ButtonState.failure(failure: failure));
    }, (data) {
      emit(const ButtonState.success());
    });
  }
}
