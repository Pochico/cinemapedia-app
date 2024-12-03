import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/bloc/local_storage_isar_bloc/local_storage_isar_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class FavoriteMoviesGridView extends StatefulWidget {
  final VoidCallback? loadMoreMovies;
  final List<Movie> movies;

  const FavoriteMoviesGridView({
    super.key,
    this.loadMoreMovies,
    required this.movies,
  });

  @override
  State<FavoriteMoviesGridView> createState() => _FavoriteMoviesGridViewState();
}

class _FavoriteMoviesGridViewState extends State<FavoriteMoviesGridView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<LocalStorageIsarBloc>().add(LoadFavoriteMoviesIsarEvent(0));

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadMoreMovies?.call();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      controller: scrollController,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: widget.movies.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            context.push('/movie/${widget.movies[index].id}');
          },
          child: Image.network(
            widget.movies[index].posterPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
