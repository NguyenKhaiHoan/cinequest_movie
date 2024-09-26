import 'package:cinequest/src/features/movie/data/models/movie_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_lists_dto.freezed.dart';
part 'movie_lists_dto.g.dart';

/// Dto
@freezed
abstract class MovieListsDto with _$MovieListsDto {
  ///Dto
  factory MovieListsDto({
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'results') List<MovieDto>? results,
    @JsonKey(name: 'total_pages') int? totalPages,
    @JsonKey(name: 'total_results') int? totalResults,
  }) = _MovieListsDto;

  /// fromJson
  factory MovieListsDto.fromJson(Map<String, dynamic> json) =>
      _$MovieListsDtoFromJson(json);
}
