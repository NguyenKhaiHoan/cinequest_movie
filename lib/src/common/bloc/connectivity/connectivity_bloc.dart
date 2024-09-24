import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../external/services/connectivity/connectivity_service.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';
part 'connectivity_bloc.freezed.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivityService;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc(this._connectivityService)
      : super(const ConnectivityState.initial()) {
    _initializeConnectivitySubscription();

    on<ConnectivityEvent>((events, emit) async {
      events.map(
          connectivityChanged: (event) => _onConnectivityChanged(event, emit));
    });
  }

  void _initializeConnectivitySubscription() {
    _connectivitySubscription = _connectivityService.connectivityStream.listen(
      (List<ConnectivityResult> result) {
        bool isConnected = (result.first == result.last
                ? result.first
                : ConnectivityResult.none) !=
            ConnectivityResult.none;
        add(EventConnectivityChanged(isConnected));
      },
    );
  }

  void _onConnectivityChanged(
      EventConnectivityChanged event, Emitter<ConnectivityState> emit) {
    if (event.isConnected) {
      emit(ConnectivityState.success(event.isConnected));
    } else {
      emit(const ConnectivityState.failure());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
