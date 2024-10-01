import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_api_error_dto.freezed.dart';
part 'tmdb_api_error_dto.g.dart';

/// Model
@freezed
class TMDBApiErrorModel with _$TMDBApiErrorModel {
  /// Model
  const factory TMDBApiErrorModel({
    @JsonKey(name: 'success') bool? success,
    @JsonKey(name: 'status_code') int? statusCode,
    @JsonKey(name: 'status_message') String? statusMessage,
  }) = _TMDBApiErrorModel;

  factory TMDBApiErrorModel.fromJson(Map<String, Object?> json) =>
      _$TMDBApiErrorModelFromJson(json);
}
