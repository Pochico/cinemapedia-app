import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  final String searchQuery;

  const SearchInitial([this.searchQuery = '']);

  @override
  List<Object> get props => [searchQuery];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> movies;

  const SearchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
