import 'package:equatable/equatable.dart';

/// Params của VerificateCodeUseCase
class VerificattionCodeParams extends Equatable {
  /// Constructor
  const VerificattionCodeParams({
    required this.verificationCode,
  });

  final String verificationCode;

  @override
  List<Object?> get props => [verificationCode];
}
