import 'package:equatable/equatable.dart';

/// Params của VerificationCodeUseCase
class VerificateCodeParams extends Equatable {
  /// Constructor
  const VerificateCodeParams({
    required this.verificationCode,
  });

  final String verificationCode;

  @override
  List<Object?> get props => [verificationCode];
}
