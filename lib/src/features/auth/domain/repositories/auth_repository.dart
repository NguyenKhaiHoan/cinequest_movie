import 'package:cinequest/src/features/auth/domain/entities/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/verification_code_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/generics/type_def.dart';
import '../entities/params/save_profile_user_params.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  FutureEither<UserCredential> signUp(AuthParams params);
  FutureEither<UserCredential> login(AuthParams params);
  FutureEither<UserCredential> signInWithGoogle();
  FutureEither<void> signOut();
  FutureEither<void> verificateCode(VerificationCodeParams params);
  FutureEither<AppUser> getProfileUser(GetProfileUserParams params);
  FutureEither<void> saveProfileUser(SaveProfileUserParams params);
}
