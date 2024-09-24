import '../../external/services/storage/cache/in_memory_store_service.dart';
import '../../features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  void setUser(AppUser? user);
}

class UserRepositoryImpl implements UserRepository {
  final _authState = InMemoryStoreService<AppUser?>(null);

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;

  @override
  void setUser(AppUser? user) {
    _authState.value = user;
  }
}
