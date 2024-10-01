import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';

/// Use case lưu email, mật khẩu vào local
class SaveEmailPasswordUseCase extends FutureAsyncUseCase<void, AuthParams> {
  /// Constructor
  SaveEmailPasswordUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({AuthParams? params}) {
    return _authRepository.saveEmailPassword(params!);
  }
}
