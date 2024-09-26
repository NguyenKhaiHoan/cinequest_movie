import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';

/// Exception khi không có data ở local
class DataLocalException extends Equatable {
  /// Lấy message từ lỗi
  DataLocalException.fromException(Object exception) {
    switch (exception) {
      case DatabaseException:
        message = (exception as DataLocalException).message;
      default:
        message = 'Error while processing data in local'.hardcoded;
        break;
    }
  }

  ///
  late final String message;

  @override
  List<Object?> get props => [message];
}
