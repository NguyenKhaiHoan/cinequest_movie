import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/save_profile_params.dart';

/// Use case lưu hồ sơ dữ liệu của người dùng
class SaveProfileUserUseCase extends UseCase<void, SaveProfileParams> {
  /// Constructor
  SaveProfileUserUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({SaveProfileParams? params}) async {
    final result = await _authRepository.saveProfilePhoto(
      SaveProfilePhotoParams(
        profilePhoto: params!.profilePhoto,
        userId: params.user.id,
      ),
    );
    return result.fold((failure) {
      throw failure;
    }, (profilePhoto) {
      return _authRepository.saveProfileUser(
        SaveProfileUserParams(
          user: params.user.copyWith(profilePhoto: profilePhoto),
        ),
      );
    });
  }
}
