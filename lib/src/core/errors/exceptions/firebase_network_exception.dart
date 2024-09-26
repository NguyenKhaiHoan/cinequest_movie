import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

/// Exception của Firebase
class FirebaseNetworkException extends Equatable {
  /// Lấy message từ lỗi [firebaseException]
  FirebaseNetworkException.fromFirebaseException(
    FirebaseException firebaseException,
  ) {
    switch (firebaseException.code) {
      default:
        message = firebaseException.message ??
            'An unexpected error occurred'.hardcoded;
        break;
    }
  }

  ///
  late final String message;

  @override
  List<Object?> get props => [message];
}
