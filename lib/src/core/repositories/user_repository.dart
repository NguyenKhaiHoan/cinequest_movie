import 'package:cinequest/src/external/services/storage/cache/in_memory_store_service.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';

/// UserReporitory được sử dụng để quản lý dữ liệu user trong vòng đời của App
abstract class UserRepository {
  Stream<AppUser?> authStateChanges();

  AppUser? get user;

  set user(AppUser? user);
}

/// Implementation của UserRepository
class UserRepositoryImpl implements UserRepository {
  final _authState = InMemoryStoreService<AppUser?>(null);

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  AppUser? get user => _authState.value;

  @override
  set user(AppUser? user) {
    _authState.value = user;
  }
}
