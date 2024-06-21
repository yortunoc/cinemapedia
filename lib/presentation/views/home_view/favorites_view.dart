import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.length == 7) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://media1.tenor.com/m/QnP4dhV6GNYAAAAC/inside-out-sad.gif'),
            // const Icon(
            //   Icons.heart_broken,
            //   color: Colors.red,
            //   size: 100,
            // ),
            const Text(
              'Ohhhh no !!!!!',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const Text(
              'Aun no tienes peliculas favoritas',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            FilledButton(
                onPressed: () {
                  context.go('/home/0');
                },
                child: const Text('Empieza a buscar'))
          ],
        ),
      );
    }

    return MovieMasonry(
      movies: favoriteMovies,
      loadNextPage: loadNextPage,
    );
  }
}
