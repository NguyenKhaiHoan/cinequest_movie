import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

/// Params
class UserParams extends Equatable {
  const UserParams({
    required this.user,
  });
  final AppUser user;

  @override
  List<Object?> get props => [user];
}
