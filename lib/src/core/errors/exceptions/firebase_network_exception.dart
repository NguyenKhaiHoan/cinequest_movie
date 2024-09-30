import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

/// Exception của Firebase
class FirebaseRemoteException extends Equatable {
  /// Lấy message từ lỗi [firebaseException]
  FirebaseRemoteException.fromFirebaseException(
    FirebaseException firebaseException,
  ) {
    message =
        firebaseException.message ?? 'An unexpected error occurred'.hardcoded;
    exception = firebaseException;
  }

  late final String message;

  late final Exception exception;

  @override
  List<Object?> get props => [message, exception];
}
