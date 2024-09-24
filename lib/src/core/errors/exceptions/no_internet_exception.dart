import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';

class NoInternetException extends Equatable {
  late final String message;

  NoInternetException.fromException() {
    message = 'No internet connection'.hardcoded;
  }

  @override
  List<Object?> get props => [message];
}
