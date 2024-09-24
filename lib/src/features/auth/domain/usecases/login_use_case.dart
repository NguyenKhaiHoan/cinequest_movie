import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/generics/type_def.dart';
import '../../../../core/generics/usecase.dart';
import '../entities/params/auth_params.dart';

class LoginUseCase implements UseCase<UserCredential, AuthParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  FutureEither<UserCredential> call({AuthParams? params}) {
    return _authRepository.login(params!);
  }
}
