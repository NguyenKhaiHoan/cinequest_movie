import 'package:cinequest/src/features/auth/domain/entities/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/generics/type_def.dart';
import '../../../../core/generics/usecase.dart';
import '../entities/user.dart';

class GetProfileUserUseCase implements UseCase<AppUser, GetProfileUserParams> {
  final AuthRepository _authRepository;

  GetProfileUserUseCase(this._authRepository);

  @override
  FutureEither<AppUser> call({GetProfileUserParams? params}) {
    return _authRepository.getProfileUser(params!);
  }
}
