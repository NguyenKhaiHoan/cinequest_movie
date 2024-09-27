import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/double_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

/// Favorite movie ở ProfilePage
class FavoriteMovieProfile extends StatelessWidget {
  /// Constructor
  const FavoriteMovieProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl<MovieRepository>().favoriteMoviesStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: AppColors.white,
          );
        }
        if (snapshot.hasError) {
          return _buildMessage('Error load favorite movies');
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildMessage('No favorite movies');
        }

        final favoriteMovies = snapshot.data!;
        return Column(
          children: [
            _buildHeader(context, favoriteMovies.length),
            gapH24,
            FavoriteMovieList(favoriteMovies: favoriteMovies),
          ],
        );
      },
    );
  }

  Widget _buildMessage(String message) {
    return SizedBox(
      child: Center(
        child: Text(message.hardcoded),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    return Row(
      children: [
        Text(
          count.toString(),
          style: context.textTheme.headlineLarge,
        ),
        gapW4,
        Text(
          'Saved\nMovie'.toUpperCase().hardcoded,
          style:
              context.textTheme.bodyMedium!.copyWith(color: AppColors.dimGray),
        ),
      ],
    );
  }
}

///
class FavoriteMovieList extends StatelessWidget {
  ///
  const FavoriteMovieList({required this.favoriteMovies, super.key});

  ///
  final List<Movie> favoriteMovies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildMovieItem(context, favoriteMovies[index]);
        },
        separatorBuilder: (context, index) => gapW8,
        itemCount: favoriteMovies.length > 2 ? 2 : favoriteMovies.length,
      ),
    );
  }

  Widget _buildMovieItem(BuildContext context, Movie movie) {
    return Container(
      height: 250,
      width: (UiUtil.deviceWidth - 8 - AppSizes.defaultSpace * 2) / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        image: DecorationImage(
          image: NetworkImage(TMDBUrl.imageBaseUrl + movie.posterPath!),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            color: AppColors.eerieBlack.withOpacity(0.5),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  SvgIcon(
                    iconPath: AppAssets.images.star.path,
                    iconSize: 10,
                  ),
                  gapW8,
                  Text(
                    movie.voteAverage!
                        .toSingleDecimal()
                        .toUpperCase()
                        .hardcoded,
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
