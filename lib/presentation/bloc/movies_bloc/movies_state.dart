import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MoviesState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> moviesByCategory;
  final Movie? movieInfo;
  final bool isLoading;

  const MoviesState({
    this.nowPlayingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
    this.moviesByCategory = const [],
    this.movieInfo,
    this.isLoading = false,
  });

  MoviesState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
    List<Movie>? moviesByCategory,
    Movie? movieInfo,
    bool? isLoading,
  }) {
    return MoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      moviesByCategory: moviesByCategory ?? this.moviesByCategory,
      movieInfo: movieInfo ?? this.movieInfo,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
        upcomingMovies,
        moviesByCategory,
        movieInfo,
        isLoading,
      ];
}
