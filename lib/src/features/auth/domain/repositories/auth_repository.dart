import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/save_profile_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/verification_code_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Auth repository
abstract class AuthRepository {
  ///
  FutureEither<UserCredential> signUp(AuthParams params);

  ///
  FutureEither<UserCredential> login(AuthParams params);

  ///
  FutureEither<UserCredential> signInWithGoogle();

  ///
  FutureEither<void> signOut();

  ///
  FutureEither<void> verificateCode(VerificationCodeParams params);

  ///
  FutureEither<AppUser> getProfileUser(GetProfileUserParams params);

  ///
  FutureEither<void> saveProfileUser(SaveProfileUserParams params);

  ///
  FutureEither<String> saveProfilePhoto(SaveProfilePhotoParams params);

  ///
  FutureEither<AuthParams> getEmailPassword();

  ///
  FutureEither<void> saveEmailPassword(AuthParams params);
}
