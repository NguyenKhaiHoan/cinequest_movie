import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/features/auth/data/models/user_model.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';

/// Mapper cho user
class UserMapper implements Mapper<UserModel, AppUser> {
  factory UserMapper() => _instance;

  UserMapper._();

  static final UserMapper _instance = UserMapper._();

  @override
  AppUser modelToEntity(UserModel dto) {
    return AppUser(
      id: dto.id,
      profilePhoto: dto.profilePhoto,
      email: dto.email,
      username: dto.username,
      name: dto.name,
      surname: dto.surname,
      createdAt: DateTime.fromMillisecondsSinceEpoch(dto.createdAt),
      authBy: dto.authBy,
    );
  }

  @override
  UserModel entityToModel(AppUser entity) {
    return UserModel(
      id: entity.id,
      profilePhoto: entity.profilePhoto,
      email: entity.email,
      username: entity.username,
      name: entity.name,
      surname: entity.surname,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      authBy: entity.authBy,
    );
  }
}
