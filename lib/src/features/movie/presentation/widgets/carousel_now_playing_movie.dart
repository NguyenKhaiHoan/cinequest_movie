import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/movie/presentation/widgets/carousel_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_circle_button.dart';
import '../../../../core/utils/ui_util.dart';
import '../../../../external/apis/themovidedb/tmdb_url.dart';
import '../blocs/now_playing_movie/now_playing_movie_bloc.dart';

class CarouselNowPlayingMovie extends StatelessWidget {
  const CarouselNowPlayingMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
      builder: (context, state) {
        return CarouselHomeView(
          subtitle: 'Sep 19',
          title: 'Premiers'.toUpperCase().hardcoded,
          titleStyle: context.textTheme.headlineMedium,
          child: state.when(
            loading: () => SizedBox(
              height: 500,
              width: UiUtil.deviceWidth,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              ),
            ),
            success: (data) => CarouselBox(
              maxHeight: 500,
              children: List.generate(
                data.length,
                (index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.eerieBlack,
                      image: DecorationImage(
                        image: NetworkImage(
                            TMDBUrl.imageBaseUrl + data[index].backdropPath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          color: AppColors.eerieBlack.withOpacity(0.5),
                        ),
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
                                CustomCircleButton(
                                    iconPath: AppAssets.images.plus.path)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            failure: (failure) => SizedBox(
              height: 500,
              width: UiUtil.deviceWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace),
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
