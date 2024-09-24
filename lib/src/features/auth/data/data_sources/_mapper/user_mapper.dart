import 'package:cinequest/src/core/generics/mapper.dart';

import '../../../domain/entities/user.dart';
import '../../models/user_dto.dart';

class UserMapper implements Mapper<UserDto, AppUser> {
  @override
  AppUser dtoToEntity(UserDto dto) {
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
  UserDto entityToDto(AppUser entity) {
    return UserDto(
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
