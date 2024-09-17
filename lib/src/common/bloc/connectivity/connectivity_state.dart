part of 'connectivity_bloc.dart';

@freezed
class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState.initial() = _ConnectivityInitialState;
  const factory ConnectivityState.success(bool isConnected) =
      _ConnectivitySuccessState;
  const factory ConnectivityState.failure() = _ConnectivityFailureState;
}
