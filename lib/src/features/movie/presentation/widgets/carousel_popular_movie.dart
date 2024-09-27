import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:cinequest/src/features/movie/presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:cinequest/src/features/movie/presentation/widgets/carousel_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Carousel dành danh sách movie phổ biến
class CarouselPopularMovie extends StatelessWidget {
  /// Construtor
  const CarouselPopularMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, state) {
        return CarouselHomeView(
          title: 'Popular now'.hardcoded,
          titleStyle: context.textTheme.bodyLarge,
          child: state.when(
            loading: () => SizedBox(
              width: UiUtil.deviceWidth,
              height: 250,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              ),
            ),
            success: (data) => CarouselBox(
              maxHeight: 250,
              children: List.generate(
                data.length,
                (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadiusLg),
                      color: AppColors.eerieBlack,
                      image: DecorationImage(
                        image: NetworkImage(
                          TMDBUrl.imageBaseUrl + data[index].posterPath!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          color: AppColors.eerieBlack.withOpacity(0.5),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              data[index]
                                  .voteAverage
                                  .toString()
                                  .toUpperCase()
                                  .hardcoded,
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            failure: (failure) => SizedBox(
              height: 250,
              width: UiUtil.deviceWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
                child: Text(
                  failure.message,
                  style: context.textTheme.bodySmall!
                      .copyWith(color: AppColors.dimGray),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
