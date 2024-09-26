import 'package:equatable/equatable.dart';

/// Params của VerificationCodeUseCase
class VerificationCodeParams extends Equatable {
  /// Constructor
  const VerificationCodeParams({
    required this.verificationCode,
  });

  ///
  final String verificationCode;

  @override
  List<Object?> get props => [verificationCode];
}
