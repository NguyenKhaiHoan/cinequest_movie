import 'dart:convert';

import 'package:cinequest/src/common/constants/app_keys.dart';
import 'package:cinequest/src/core/errors/exceptions/data_local_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';

/// Local DataSource
abstract class AuthLocalDataSource {
  Future<AuthParams> getEmailPassword();
  Future<void> saveEmailPassword(AuthParams params);
}

/// Implementation của AuthLocalDataSource sử dụng SecureStorage
class AuthSecureStorageDataSourceImpl implements AuthLocalDataSource {
  /// Constructor
  AuthSecureStorageDataSourceImpl({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;

  final SecureStorageService _secureStorageService;

  @override
  Future<AuthParams> getEmailPassword() async {
    try {
      if (await _secureStorageService.contains(authKey)) {
        final result = await _secureStorageService.getData(authKey);
        final authParams =
            AuthParams.fromJson(json.decode(result!) as Map<String, dynamic>);
        return AuthParams(
          email: authParams.email,
          password: authParams.password,
        );
      }
      return const AuthParams(email: '', password: '');
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException().message,
      );
    }
  }

  @override
  Future<void> saveEmailPassword(AuthParams params) async {
    try {
      await _secureStorageService.saveData(
        authKey,
        json.encode(params.toJson()),
      );
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException().message,
      );
    }
  }
}
