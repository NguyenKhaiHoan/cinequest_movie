import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/generics/type_def.dart';
import '../../../../core/generics/usecase.dart';

class SignInWithGoogleUseCase implements UseCase<UserCredential, NoParams> {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  @override
  FutureEither<UserCredential> call({NoParams? params}) {
    return _authRepository.signInWithGoogle();
  }
}
