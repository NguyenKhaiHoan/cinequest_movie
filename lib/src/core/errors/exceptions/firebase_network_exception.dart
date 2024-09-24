import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseNetworkException extends Equatable {
  late final String message;

  FirebaseNetworkException.fromFirebaseException(
      FirebaseException firebaseException) {
    switch (firebaseException.code) {
      default:
        message = firebaseException.message ??
            'An unexpected error occurred'.hardcoded;
        break;
    }
  }

  @override
  List<Object?> get props => [message];
}
