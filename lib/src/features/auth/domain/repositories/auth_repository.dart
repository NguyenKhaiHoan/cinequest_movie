import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/profile_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/user_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/verification_code_params.dart';

/// Auth repository
abstract class AuthRepository {
  FutureEither<AppUser> getProfileUser();
  FutureEither<void> saveProfileUser(UserParams params);
  FutureEither<void> signUp(AuthParams params);
  FutureEither<void> login(AuthParams params);
  FutureEither<void> signInWithGoogle();
  FutureEither<void> signOut();
  FutureEither<void> verificateCode(VerificattionCodeParams params);
  FutureEither<String> saveProfilePhoto(ProfileParams params);
  FutureEither<AuthParams> getEmailPassword();
  FutureEither<void> saveEmailPassword(AuthParams params);
}
