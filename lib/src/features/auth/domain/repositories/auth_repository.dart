import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/save_profile_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/verification_code_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Auth repository
abstract class AuthRepository {
  FutureEither<AppUser> getProfileUser(GetProfileUserParams params);
  FutureEither<void> saveProfileUser(SaveProfileUserParams params);
  FutureEither<UserCredential> signUp(AuthParams params);
  FutureEither<UserCredential> login(AuthParams params);
  FutureEither<UserCredential> signInWithGoogle();
  FutureEither<void> signOut();
  FutureEither<void> verificateCode(VerificateCodeParams params);

  FutureEither<String> saveProfilePhoto(SaveProfilePhotoParams params);
  FutureEither<AuthParams> getEmailPassword();
  FutureEither<void> saveEmailPassword(AuthParams params);
}
