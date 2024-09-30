import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/verification_code_params.dart';

/// Use case xác thực code
class VerificateCodeUseCase extends UseCase<void, VerificateCodeParams> {
  /// Constructor
  VerificateCodeUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({VerificateCodeParams? params}) {
    return _authRepository.verificateCode(params!);
  }
}
