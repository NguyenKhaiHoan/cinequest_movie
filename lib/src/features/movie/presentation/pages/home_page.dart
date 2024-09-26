import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/features/movie/presentation/blocs/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:cinequest/src/features/movie/presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:cinequest/src/features/movie/presentation/widgets/carousel_now_playing_movie.dart';
import 'package:cinequest/src/features/movie/presentation/widgets/carousel_popular_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_mixins/home_page.mixin.dart';

/// Trang Home
class HomePage extends StatefulWidget {
  /// Constructor
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBottomDivider(
        leadingWidth: 110,
        leading: PaddingAppBar(
          isLeft: true,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SvgIcon(iconPath: AppAssets.images.mapPin.path),
              gapW4,
              Text('Taskent', style: context.textTheme.bodyMedium),
            ],
          ),
        ),
        actions: [
          PaddingAppBar(
            isLeft: false,
            child: CustomCircleButton(
              iconPath: AppAssets.images.magnifyingGlass.path,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => NowPlayingMovieBloc(sl())
                ..add(const NowPlayingMovieEvent.get()),
            ),
            BlocProvider(
              create: (context) =>
                  PopularMovieBloc(sl())..add(const PopularMovieEvent.get()),
            ),
          ],
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH48,
              CarouselNowPlayingMovie(),
              gapH48,
              CarouselPopularMovie(),
              gapH48,
              // CarouselCinema()
            ],
          ),
        ),
      ),
      // body: const Center(
      //   child: Text('Home Page'),
      // ),
    );
  }
}
