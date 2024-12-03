import 'package:flutter/widgets.dart';

enum MovieCategory { nowPlaying, popular, topRated, upcoming }

@immutable
abstract class MoviesEvent {}

class LoadNextPageEvent extends MoviesEvent {
  final MovieCategory category;

  LoadNextPageEvent(this.category);

  List<Object?> get props => [category];
}

class LoadMovieByIdEvent extends MoviesEvent {
  final String movieId;

  LoadMovieByIdEvent(this.movieId);

  List<Object?> get props => [movieId];
}

class GetMoviesByCategoryEvent extends MoviesEvent {
  final String categoryId;

  GetMoviesByCategoryEvent(this.categoryId);

  List<Object?> get props => [categoryId];
}
