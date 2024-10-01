import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/bloc/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/usecases/delete_movie_local_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/params/movie_params.dart';
import 'package:cinequest/src/features/movie/domain/usecases/save_movie_local_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/stream_favorite_movie_usecase.dart';
import 'package:cinequest/src/features/movie/presentation/blocs/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:cinequest/src/features/movie/presentation/widgets/carousel_home_view.dart';
import 'package:cinequest/src/features/movie/presentation/widgets/now_playing_movie_carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_mixins/carousel_now_playing_movie.mixin.dart';

/// Carousel dành danh sách movie đang chiếu
class CarouselNowPlayingMovie extends StatefulWidget {
  /// Constructor
  const CarouselNowPlayingMovie({super.key});

  @override
  State<CarouselNowPlayingMovie> createState() =>
      _CarouselNowPlayingMovieState();
}

class _CarouselNowPlayingMovieState extends State<CarouselNowPlayingMovie>
    with CarouselNowPlayingMovieMixin {
  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
      builder: (context, state) {
        return CarouselHomeView(
          subtitle: time.formatToMMMDD(),
          title: 'Premiers'.toUpperCase().hardcoded,
          titleStyle: context.textTheme.headlineMedium,
          child: state.when(
            loading: _buildLoadingState,
            success: _buildSuccessState,
            failure: _buildFailureState,
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 500,
      width: UiUtil.deviceWidth,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildSuccessState(List<Movie> data) {
    return StreamBuilder(
      stream: sl<StreamFavoriteMovieUsecase>().call(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: UiUtil.deviceWidth,
            child: const CircularProgressIndicator(
              color: AppColors.white,
            ),
          );
        }
        if (snapshot.hasError) {
          return CarouselBox(
            maxHeight: 500,
            children: List.generate(
              data.length,
              (index) => NowPlayingMovieCarouselItem(
                movie: data[index],
                favoriteMovies: data,
                listener: _listener,
                toggleFavorite: _toggleFavorite,
                isFavorite: false,
              ),
            ),
          );
        }
        final favoriteMovies = snapshot.data ?? [];
        return CarouselBox(
          maxHeight: 500,
          children: List.generate(
            data.length,
            (index) => NowPlayingMovieCarouselItem(
              movie: data[index],
              favoriteMovies: data,
              listener: _listener,
              toggleFavorite: _toggleFavorite,
              isFavorite:
                  favoriteMovies.any((movie) => movie.id == data[index].id),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFailureState(Failure failure) {
    return SizedBox(
      height: 500,
      width: UiUtil.deviceWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Text(
          failure.message,
          style:
              context.textTheme.bodySmall!.copyWith(color: AppColors.dimGray),
        ),
      ),
    );
  }
}
