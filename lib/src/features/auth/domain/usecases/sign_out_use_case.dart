import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';

/// Use case đăng xuất
class SignOutUseCase extends UseCase<void, NoParams> {
  /// Constructor
  SignOutUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({NoParams? params}) {
    return _authRepository.signOut();
  }
}
