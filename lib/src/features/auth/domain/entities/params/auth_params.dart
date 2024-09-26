import 'package:equatable/equatable.dart';

/// Params của LoginUseCase, SignUpUseCase
class AuthParams extends Equatable {
  /// Constructor
  const AuthParams({
    required this.email,
    required this.password,
  });

  ///
  final String email;

  ///
  final String password;

  @override
  List<Object?> get props => [email, password];
}
