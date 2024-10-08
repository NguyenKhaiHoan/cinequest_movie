import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/features/movie/data/models/movie_model.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';

/// Mapper cho movie
class MovieMapper implements Mapper<MovieModel, Movie> {
  ///
  factory MovieMapper() => _instance;

  MovieMapper._();

  static final MovieMapper _instance = MovieMapper._();

  @override
  Movie modelToEntity(MovieModel dto) {
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
  MovieModel entityToModel(Movie entity) {
    return MovieModel(
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

  /// Maps movie sang object cho Sqlite
  Map<String, dynamic> entityToObject(Movie entity) {
    return {
      'adult': entity.adult ?? false ? 1 : 0,
      'backdrop_path': entity.backdropPath,
      'genre_ids': entity.genreIds?.join(','),
      'id': entity.id,
      'original_language': entity.originalLanguage,
      'original_title': entity.originalTitle,
      'overview': entity.overview,
      'popularity': entity.popularity,
      'poster_path': entity.posterPath,
      'release_date': entity.releaseDate?.toIso8601String(),
      'title': entity.title,
      'video': entity.video ?? false ? 1 : 0,
      'vote_average': entity.voteAverage,
      'vote_count': entity.voteCount,
    };
  }

  /// Maps object cho Sqlite sang movie
  Movie objectToEntity(Map<String, dynamic> object) {
    return Movie(
      adult: (object['adult'] as int) == 1,
      backdropPath: object['backdrop_path'] as String?,
      genreIds:
          (object['genre_ids'] as String?)?.split(',').map(int.parse).toList(),
      id: object['id'] as int?,
      originalLanguage: object['original_language'] as String?,
      originalTitle: object['original_title'] as String?,
      overview: object['overview'] as String?,
      popularity: object['popularity'] as double?,
      posterPath: object['poster_path'] as String?,
      releaseDate: DateTime.tryParse(object['release_date'] as String? ?? ''),
      title: object['title'] as String?,
      video: (object['video'] as int) == 1,
      voteAverage: object['vote_average'] as double?,
      voteCount: object['vote_count'] as int?,
    );
  }
}
