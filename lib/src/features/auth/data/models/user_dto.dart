import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// Dto
@freezed
class UserDto with _$UserDto {
  /// Dto
  const factory UserDto({
    required String id,
    @JsonKey(name: 'profile_photo') required String profilePhoto,
    required String email,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'surname') required String surname,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'auth_by') required String authBy,
  }) = _UserDto;

  /// fromJson
  factory UserDto.fromJson(Map<String, Object?> json) =>
      _$UserDtoFromJson(json);
}
