import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';

/// Exception khi không có data ở local
class DataLocalException extends Equatable {
  /// Lấy message từ lỗi
  DataLocalException.fromException() {
    message = 'Error while processing data in local'.hardcoded;
  }

  late final String message;

  @override
  List<Object?> get props => [message];
}
