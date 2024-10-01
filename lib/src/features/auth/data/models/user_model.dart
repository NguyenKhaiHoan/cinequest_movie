import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Model
@freezed
class UserModel with _$UserModel {
  /// Model
  const factory UserModel({
    required String id,
    @JsonKey(name: 'profile_photo') required String profilePhoto,
    required String email,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'surname') required String surname,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'auth_by') required String authBy,
  }) = _UserModel;

  /// fromJson
  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
