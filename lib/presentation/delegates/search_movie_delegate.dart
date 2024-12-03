import 'dart:async';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/bloc/search_bloc/search_bloc_bloc.dart';
import 'package:cinemapedia/presentation/bloc/search_bloc/search_bloc_event.dart';
import 'package:cinemapedia/presentation/bloc/search_bloc/search_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/shared/movie_item.dart';

class SearchMovieDelegate extends SearchDelegate {
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  void _onQueryChanged(BuildContext context, String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 700), () {
      final searchBloc = context.read<SearchBloc>();
      searchBloc.add(OnQueryChanged(query));
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = state is SearchInitial ? state.searchQuery : '';
              showSuggestions(context);
            },
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
          ),
          onPressed: () {
            context.read<SearchBloc>().add(OnQueryChanged(query));
            close(context, null);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Introduce un texto para buscar'),
      );
    }

    final searchBloc = context.read<SearchBloc>();
    searchBloc.add(OnQueryChanged(query));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return const Center(
              child: Text('No se encontraron resultados'),
            );
          }

          return GridView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieItem(movie: movie);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.5,
            ),
          );
        } else if (state is SearchError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No se encontraron resultados'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Introduce un texto para buscar'));
    }

    _onQueryChanged(context, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchLoaded) {
          final suggestions = state.movies.take(10).toList();
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final movie = suggestions[index];
              return ListTile(
                title: Text(movie.title),
                onTap: () {
                  query = movie.title;
                  showResults(context);
                },
              );
            },
          );
        } else if (state is SearchError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No se encontraron sugerencias'));
        }
      },
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
