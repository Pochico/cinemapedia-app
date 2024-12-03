import 'package:cinemapedia/presentation/bloc/local_storage_isar_bloc/local_storage_isar_bloc_bloc.dart';
import 'package:cinemapedia/presentation/widgets/movies/favorite_movies_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalStorageIsarBloc, LocalStorageIsarBlocState>(
      buildWhen: (previous, current) =>
          previous.favoriteMovies != current.favoriteMovies,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
          ),
          body: state.favoriteMovies.isNotEmpty
              ? FavoriteMoviesGridView(
                  movies: state.favoriteMovies,
                  loadMoreMovies: () => context
                      .read<LocalStorageIsarBloc>()
                      .add(LoadFavoriteMoviesIsarEvent(
                          state.favoriteMovies.length)),
                )
              : const Center(
                  child: Text('No favorites yet'),
                ),
        );
      },
    );
  }
}
