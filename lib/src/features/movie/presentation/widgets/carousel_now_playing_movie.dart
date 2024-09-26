import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/bloc/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/save_movie_local_params.dart';
import 'package:cinequest/src/features/movie/domain/usecases/save_movie_local_use_case.dart';
import 'package:cinequest/src/features/movie/presentation/blocs/movie_local/movie_local_bloc.dart';
import 'package:cinequest/src/features/movie/presentation/blocs/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:cinequest/src/features/movie/presentation/widgets/carousel_home_view.dart';
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
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
      builder: (context, state) {
        return CarouselHomeView(
          subtitle: 'Sep 19',
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
    return CarouselBox(
      maxHeight: 500,
      children: List.generate(
        data.length,
        (index) => NowPlayingMovieCarouselItem(
          movie: data[index],
          listener: _listener,
          saveMovieLocal: _saveMovieLocal,
        ),
      ),
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

///
class NowPlayingMovieCarouselItem extends StatelessWidget {
  ///
  const NowPlayingMovieCarouselItem({
    required this.movie,
    required this.listener,
    required this.saveMovieLocal,
    super.key,
  });

  ///
  final void Function(
    BuildContext context,
    ButtonState state,
    bool isFavorite,
  ) listener;

  ///
  final void Function(BuildContext context, Movie movie) saveMovieLocal;

  ///
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        color: AppColors.eerieBlack,
        image: DecorationImage(
          image: NetworkImage(TMDBUrl.imageBaseUrl + movie.backdropPath!),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(color: AppColors.eerieBlack.withOpacity(0.5)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CustomButton(
                    buttonType: ButtonType.elevated,
                    text: 'Tickets'.toUpperCase().hardcoded,
                    textColor: AppColors.black,
                  ),
                  const Spacer(),
                  FavoriteButton(
                    movie: movie,
                    listener: listener,
                    saveMovieLocal: saveMovieLocal,
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

///
class FavoriteButton extends StatelessWidget {
  ///
  const FavoriteButton({
    required this.movie,
    required this.listener,
    required this.saveMovieLocal,
    super.key,
  });

  ///
  final Movie movie;

  ///
  final void Function(
    BuildContext context,
    ButtonState state,
    bool isFavorite,
  ) listener;

  ///
  final void Function(BuildContext context, Movie movie) saveMovieLocal;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ButtonBloc()),
        BlocProvider(create: (_) => MovieLocalBloc()),
      ],
      child: BlocBuilder<MovieLocalBloc, MovieLocalState>(
        builder: (context, movieLocalState) {
          return BlocListener<ButtonBloc, ButtonState>(
            listener: (context, buttonState) =>
                listener(context, buttonState, movieLocalState.isFavorite),
            child: CustomButton(
              buttonType: movieLocalState.isFavorite
                  ? ButtonType.elevated
                  : ButtonType.outlined,
              isLoading: movieLocalState is ButtonLoadingState,
              colorFilter: movieLocalState.isFavorite
                  ? const ColorFilter.mode(AppColors.black, BlendMode.srcIn)
                  : const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              iconPath: movieLocalState.isFavorite
                  ? AppAssets.images.check.path
                  : AppAssets.images.plus.path,
              onPressed: () => saveMovieLocal(context, movie),
            ),
          );
        },
      ),
    );
  }
}
