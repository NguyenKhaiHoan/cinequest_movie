import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/generics/type_def.dart';
import '../../../../core/generics/usecase.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  @override
  FutureEither<void> call({NoParams? params}) {
    return _authRepository.signOut();
  }
}
