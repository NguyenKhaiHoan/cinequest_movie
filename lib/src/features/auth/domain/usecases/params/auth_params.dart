import 'package:equatable/equatable.dart';

/// Params của LoginUseCase, SignUpUseCase
class AuthParams extends Equatable {
  /// Constructor
  const AuthParams({
    required this.email,
    required this.password,
  });

  factory AuthParams.fromJson(Map<String, dynamic> json) {
    return AuthParams(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  final String email;

  final String password;

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}
