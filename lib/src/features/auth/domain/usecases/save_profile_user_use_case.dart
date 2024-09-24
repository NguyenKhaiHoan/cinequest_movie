import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/generics/type_def.dart';
import '../../../../core/generics/usecase.dart';
import '../entities/params/save_profile_user_params.dart';

class SaveProfileUserUseCase implements UseCase<void, SaveProfileUserParams> {
  final AuthRepository _authRepository;

  SaveProfileUserUseCase(this._authRepository);

  @override
  FutureEither<void> call({SaveProfileUserParams? params}) {
    return _authRepository.saveProfileUser(params!);
  }
}
