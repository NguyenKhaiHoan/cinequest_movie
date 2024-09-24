import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';

import '../../models/movie_dto.dart';

class MovieMapper implements Mapper<MovieDto, Movie> {
  @override
  Movie dtoToEntity(MovieDto dto) {
    return Movie(
      adult: dto.adult,
      backdropPath: dto.backdropPath,
      genreIds: dto.genreIds,
      id: dto.id,
      originalLanguage: dto.originalLanguage,
      originalTitle: dto.originalTitle,
      overview: dto.overview,
      popularity: dto.popularity,
      posterPath: dto.posterPath,
      releaseDate: DateTime.parse(dto.releaseDate ?? ''),
      title: dto.title,
      video: dto.video,
      voteAverage: dto.voteAverage,
      voteCount: dto.voteCount,
    );
  }

  @override
  MovieDto entityToDto(Movie entity) {
    return MovieDto(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      genreIds: entity.genreIds,
      id: entity.id,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate!.toFormattedString(),
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }
}
