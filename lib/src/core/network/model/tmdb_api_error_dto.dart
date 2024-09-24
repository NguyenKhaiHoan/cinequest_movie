import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_api_error_dto.freezed.dart';
part 'tmdb_api_error_dto.g.dart';

@freezed
class TMDBApiErrorDto with _$TMDBApiErrorDto {
  const factory TMDBApiErrorDto({
    @JsonKey(name: "success") bool? success,
    @JsonKey(name: "status_code") int? statusCode,
    @JsonKey(name: "status_message") String? statusMessage,
  }) = _TMDBApiErrorDto;

  factory TMDBApiErrorDto.fromJson(Map<String, Object?> json) =>
      _$TMDBApiErrorDtoFromJson(json);
}
