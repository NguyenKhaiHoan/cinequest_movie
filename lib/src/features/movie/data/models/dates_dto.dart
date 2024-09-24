import 'package:freezed_annotation/freezed_annotation.dart';

part 'dates_dto.freezed.dart';
part 'dates_dto.g.dart';

@freezed
abstract class DatesDto with _$DatesDto {
  factory DatesDto({
    @JsonKey(name: "maximum") DateTime? maximum,
    @JsonKey(name: "minimum") DateTime? minimum,
  }) = _DatesDto;
  factory DatesDto.fromJson(Map<String, dynamic> json) =>
      _$DatesDtoFromJson(json);
}
