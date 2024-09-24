import 'package:cinequest/src/features/auth/domain/entities/params/verification_code_params.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/generics/type_def.dart';
import '../../../../core/generics/usecase.dart';

class VerificateCodeUseCase implements UseCase<void, VerificationCodeParams> {
  final AuthRepository _authRepository;

  VerificateCodeUseCase(this._authRepository);

  @override
  FutureEither<void> call({VerificationCodeParams? params}) {
    return _authRepository.verificateCode(params!);
  }
}
