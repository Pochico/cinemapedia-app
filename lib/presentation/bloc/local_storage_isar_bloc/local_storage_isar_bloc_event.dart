part of 'local_storage_isar_bloc_bloc.dart';

abstract class LocalStorageIsarBlocEvent {
  const LocalStorageIsarBlocEvent();
}

class LoadFavoriteMoviesIsarEvent extends LocalStorageIsarBlocEvent {
  final int offset;

  LoadFavoriteMoviesIsarEvent(this.offset);
}

class ToggleFavoriteMovieIsarEvent extends LocalStorageIsarBlocEvent {
  final Movie movie;

  ToggleFavoriteMovieIsarEvent(this.movie);
}

class GetIsMovieFavoriteEvent extends LocalStorageIsarBlocEvent {
  final int movieId;

  GetIsMovieFavoriteEvent(this.movieId);
}
