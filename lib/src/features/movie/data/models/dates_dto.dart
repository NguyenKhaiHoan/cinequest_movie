import 'package:freezed_annotation/freezed_annotation.dart';

part 'dates_dto.freezed.dart';
part 'dates_dto.g.dart';

/// Dto
@freezed
abstract class DatesDto with _$DatesDto {
  /// Dto
  factory DatesDto({
    @JsonKey(name: 'maximum') DateTime? maximum,
    @JsonKey(name: 'minimum') DateTime? minimum,
  }) = _DatesDto;

  /// fromJson
  factory DatesDto.fromJson(Map<String, dynamic> json) =>
      _$DatesDtoFromJson(json);
}
