import 'dart:async';

import 'package:cinequest/src/core/errors/exceptions/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity_bloc.freezed.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

/// Quản lý trạng thái Connectivity (kết nối mạng)
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  /// Constructor
  ConnectivityBloc({required ConnectivityService connectivityService})
      : _connectivityService = connectivityService,
        super(const ConnectivityState.initial()) {
    _initializeConnectivitySubscription();

    on<ConnectivityEvent>((events, emit) async {
      events.map(
        connectivityChanged: (event) => _onConnectivityChanged(event, emit),
      );
    });
  }
  final ConnectivityService _connectivityService;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  void _initializeConnectivitySubscription() {
    _connectivitySubscription = _connectivityService.connectivityStream.listen(
      (List<ConnectivityResult> result) {
        /// Lấy tình trạng kết nối mới nhất để so sánh
        final isConnected = result.last != ConnectivityResult.none;
        add(EventConnectivityChanged(isConnected: isConnected));
      },
    );
  }

  void _onConnectivityChanged(
    EventConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    if (event.isConnected) {
      emit(const ConnectivityState.success());
    } else {
      emit(
        ConnectivityState.failure(
          failure:
              Failure(message: NoInternetException.fromException().message),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
