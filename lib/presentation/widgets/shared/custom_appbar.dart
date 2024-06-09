import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/movies/movies_repository_provider.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(), // este toma todo el espacio posible del row
              IconButton(
                onPressed: () {
                  final movieRepository = ref.read(movieRepositoryProvider);
                  showSearch<Movie?>(
                          context: context,
                          delegate: SearchMovieDelegate(
                              searchMovies: movieRepository.searchMovies))
                      .then((movie) {
                    if (movie == null) {
                      return null;
                    }
                    context.push('/movie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search),
                color: colors.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
