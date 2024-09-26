import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';

/// Exception khi không có kết nối mạng
class NoInternetException extends Equatable {
  /// Lấy message từ lỗi
  NoInternetException.fromException() {
    message = 'No internet connection'.hardcoded;
  }

  ///
  late final String message;

  @override
  List<Object?> get props => [message];
}
