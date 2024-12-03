import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepositoryImpl repository;

  int nowPlayingPage = 1;
  int popularPage = 1;
  int topRatedPage = 1;
  int upcomingPage = 1;

  MoviesBloc(this.repository) : super(const MoviesState()) {
    on<LoadNextPageEvent>(_onLoadNextPage);
    on<LoadMovieByIdEvent>(_onLoadMovieById);
    on<GetMoviesByCategoryEvent>(_onGetMoviesByCategory);
  }

  Future<void> _onLoadNextPage(
      LoadNextPageEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));

    switch (event.category) {
      case MovieCategory.nowPlaying:
        final movies = await repository.getNowPlaying(page: nowPlayingPage);
        emit(state.copyWith(
          nowPlayingMovies: [...state.nowPlayingMovies, ...movies],
        ));
        nowPlayingPage++;
        break;

      case MovieCategory.popular:
        final movies = await repository.getPopular(page: popularPage);
        emit(state.copyWith(
          popularMovies: [...state.popularMovies, ...movies],
        ));
        popularPage++;
        break;

      case MovieCategory.topRated:
        final movies = await repository.getTopRated(page: topRatedPage);
        emit(state.copyWith(
          topRatedMovies: [...state.topRatedMovies, ...movies],
        ));
        topRatedPage++;
        break;

      case MovieCategory.upcoming:
        final movies = await repository.getUpcoming(page: upcomingPage);
        emit(state.copyWith(
          upcomingMovies: [...state.upcomingMovies, ...movies],
        ));
        upcomingPage++;
        break;
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onLoadMovieById(
      LoadMovieByIdEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));
    final movie = await repository.getMovieById(event.movieId);
    emit(state.copyWith(
      movieInfo: movie,
      isLoading: false,
    ));
  }

  Future<void> _onGetMoviesByCategory(
      GetMoviesByCategoryEvent event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));
    final movies = await repository.getMoviesByCategory(event.categoryId);
    emit(state.copyWith(
      moviesByCategory: movies,
      isLoading: false,
    ));
  }
}
