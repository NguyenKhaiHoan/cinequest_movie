import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';

/// Use case đăng nhập
class LoginUseCase extends FutureAsyncUseCase<void, AuthParams> {
  /// Constructor
  LoginUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({AuthParams? params}) {
    return _authRepository.login(params!);
  }
}
