import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/verification_code_params.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';

/// Use case xác thực code
class VerificateCodeUseCase extends UseCase<void, VerificationCodeParams> {
  /// Constructor
  VerificateCodeUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({VerificationCodeParams? params}) {
    return _authRepository.verificateCode(params!);
  }
}
