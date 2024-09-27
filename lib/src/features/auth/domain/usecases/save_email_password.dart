import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';

/// Use case lưu email, mật khẩu vào local
class SaveEmailPasswordUseCase extends UseCase<void, AuthParams> {
  /// Constructor
  SaveEmailPasswordUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({AuthParams? params}) {
    return _authRepository.saveEmailPassword(params!);
  }
}
