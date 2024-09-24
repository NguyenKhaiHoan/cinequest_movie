import 'package:equatable/equatable.dart';

class VerificationCodeParams extends Equatable {
  final String verificationCode;
  const VerificationCodeParams({
    required this.verificationCode,
  });

  @override
  List<Object?> get props => [verificationCode];
}
