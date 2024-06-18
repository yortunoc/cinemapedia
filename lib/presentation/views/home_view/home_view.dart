import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/movies/movies_providers.dart';
import '../../providers/movies/movies_slideshow_provider.dart';
import '../../widgets/movies/movie_horizontal_listview.dart';
import '../../widgets/movies/movies_slideshow.dart';
import '../../widgets/shared/custom_appbar.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView();

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMovieProvider.notifier).loadNextPage();
    ref.read(upcomingMovieProvider.notifier).loadNextPage();
    ref.read(topRaterMovieProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMovieProvider);
    final topRaterMovies = ref.watch(topRaterMovieProvider);
    final upcomingMovies = ref.watch(upcomingMovieProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesSlideShow(movies: slideShowMovies),
              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: 'Viernes 31',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListView(
                movies: upcomingMovies,
                title: 'Proximamente',
                subTitle: 'Viernes 31',
                loadNextPage: () {
                  ref.read(upcomingMovieProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListView(
                movies: popularMovies,
                title: 'Populares',
                subTitle: 'Este mes',
                loadNextPage: () {
                  ref.read(popularMovieProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListView(
                movies: topRaterMovies,
                title: 'Mejor calificados',
                subTitle: 'desde siempre',
                loadNextPage: () {
                  ref.read(topRaterMovieProvider.notifier).loadNextPage();
                },
              )
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
