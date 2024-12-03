import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/datasources/actorsdb_datasource.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/presentation/bloc/actors_bloc/actors_by_movie_bloc.dart';
import 'package:cinemapedia/presentation/bloc/local_storage_isar_bloc/local_storage_isar_bloc_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_event.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_state.dart';
import 'package:cinemapedia/presentation/widgets/movies/genre_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieScreen extends StatelessWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<MoviesBloc>(
        create: (context) =>
            MoviesBloc(MovieRepositoryImpl(MoviedbDatasource()))
              ..add(LoadMovieByIdEvent(movieId)),
      ),
      BlocProvider<ActorsByMovieBloc>(
        create: (context) =>
            ActorsByMovieBloc(ActorRepositoryImpl(ActorsDbDataSource()))
              ..add(LoadActorsByMovieEvent(movieId)),
      ),
    ], child: _HomeScreen(movieId));
  }
}

class _HomeScreen extends StatelessWidget {
  final String movieId;
  const _HomeScreen(this.movieId);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.movieInfo == null || movieId == 'no-id') {
            return const Center(child: Text('No se encontró la película'));
          }

          final movie = state.movieInfo!;

          return CustomScrollView(slivers: [
            _CustomSliverAppBar(size: size, movie: movie),
            SliverToBoxAdapter(
              child: _MovieDetails(movie: movie),
            )
          ]);
        },
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    print(GoRouter.of(context).location);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 1,
                    children: List.generate(movie.genreIds.length, (index) {
                      return GenreTag(
                        isSelected: false,
                        genre: movie.genreIds[index],
                        genreId: movie.genreIds[index],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            movie.overview,
            style: textStyles.bodyMedium,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('Actores', style: textStyles.titleLarge),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 350,
          child: BlocBuilder<ActorsByMovieBloc, ActorsByMovieState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.actors.isEmpty) {
                return const Center(
                  child: Text('No se encontraron actores'),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: state.actors.length,
                itemBuilder: (context, index) {
                  final actor = state.actors[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(actor.profilePath),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text(
                          actor.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({
    required this.size,
    required this.movie,
  });

  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    context.read<LocalStorageIsarBloc>().add(GetIsMovieFavoriteEvent(movie.id));

    return BlocBuilder<LocalStorageIsarBloc, LocalStorageIsarBlocState>(
      builder: (context, state) {
        final isFavorite = state.isFavorite;
        // final isFavorite = state.favoriteMovies
        // .any((favoriteMovie) => favoriteMovie.id == movie.id);

        return SliverAppBar(
          expandedHeight: size.height * 0.7,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          actions: [
            ElevatedButton(
              onPressed: () => context
                  .read<LocalStorageIsarBloc>()
                  .add(ToggleFavoriteMovieIsarEvent(movie)),
              child: isFavorite
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.white70,
                    ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(10),
            title: Text(
              movie.title,
              style: const TextStyle(color: Colors.white),
            ),
            background: Stack(
              children: [
                SizedBox.expand(
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [.6, .95],
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        stops: [0, .5],
                        colors: [Colors.black87, Colors.transparent],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
