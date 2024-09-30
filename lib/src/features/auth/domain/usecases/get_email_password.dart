import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';

/// Use case lấy email, mật khẩu từ local
class GetEmailPasswordUseCase extends UseCase<AuthParams, NoParams> {
  /// Constructor
  GetEmailPasswordUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<AuthParams> call({NoParams? params}) {
    return _authRepository.getEmailPassword();
  }
}
