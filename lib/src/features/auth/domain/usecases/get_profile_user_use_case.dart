import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';

/// Usecase lấy dữ liệu hồ sơ của user
class GetProfileUserUseCase extends UseCase<AppUser, GetProfileUserParams> {
  /// Constructor
  GetProfileUserUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<AppUser> call({GetProfileUserParams? params}) {
    return _authRepository.getProfileUser(params!);
  }
}
