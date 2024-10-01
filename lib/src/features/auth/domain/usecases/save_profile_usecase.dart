import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/profile_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/user_params.dart';

/// Use case lưu hồ sơ dữ liệu của người dùng
class SaveProfileUserUseCase extends FutureAsyncUseCase<void, ProfileParams> {
  /// Constructor
  SaveProfileUserUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({ProfileParams? params}) async {
    final result = await _authRepository.saveProfilePhoto(
      ProfileParams(
        profilePhoto: params!.profilePhoto,
        user: params.user,
      ),
    );
    return result.fold((failure) {
      throw failure;
    }, (profilePhoto) {
      return _authRepository.saveProfileUser(
        UserParams(
          user: params.user.copyWith(profilePhoto: profilePhoto),
        ),
      );
    });
  }
}
