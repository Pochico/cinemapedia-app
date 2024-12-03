import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:cinemapedia/presentation/bloc/local_storage_isar_bloc/local_storage_isar_bloc_event.dart';
part 'package:cinemapedia/presentation/bloc/local_storage_isar_bloc/local_storage_isar_bloc_state.dart';

class LocalStorageIsarBloc
    extends Bloc<LocalStorageIsarBlocEvent, LocalStorageIsarBlocState> {
  final LocalStorageRepositoryImpl localStorageRepository;

  LocalStorageIsarBloc(this.localStorageRepository)
      : super(const LocalStorageIsarBlocState(isFavorite: false)) {
    on<LoadFavoriteMoviesIsarEvent>(_onLoadFavoriteMoviesIsar);
    on<GetIsMovieFavoriteEvent>(_onGetIsMovieFavorite);
    on<ToggleFavoriteMovieIsarEvent>(_onToggleFavoriteMovieIsar);
  }

  Future<void> _onLoadFavoriteMoviesIsar(LoadFavoriteMoviesIsarEvent event,
      Emitter<LocalStorageIsarBlocState> emit) async {
    final newFavoriteMovies = await localStorageRepository.loadFavoriteMovies(
        limit: 15, offset: event.offset);

    final updatedFavorites = List<Movie>.from(state.favoriteMovies);
    for (var movie in newFavoriteMovies) {
      if (!updatedFavorites
          .any((existingMovie) => existingMovie.id == movie.id)) {
        updatedFavorites.add(movie);
      }
    }

    emit(state.copyWith(favoriteMovies: updatedFavorites));
  }

  Future<void> _onToggleFavoriteMovieIsar(ToggleFavoriteMovieIsarEvent event,
      Emitter<LocalStorageIsarBlocState> emit) async {
    await localStorageRepository.toggleFavorite(event.movie);

    final favoriteMovies = List<Movie>.from(state.favoriteMovies);
    final index =
        favoriteMovies.indexWhere((movie) => movie.id == event.movie.id);

    if (index == -1) {
      favoriteMovies.add(event.movie);
    } else {
      favoriteMovies.removeAt(index);
    }

    emit(state.copyWith(favoriteMovies: favoriteMovies));

    emit(state.copyWith(isFavorite: index == -1));
  }

  Future<void> _onGetIsMovieFavorite(GetIsMovieFavoriteEvent event,
      Emitter<LocalStorageIsarBlocState> emit) async {
    final isFavorite =
        await localStorageRepository.isMovieFavorite(event.movieId);
    emit(state.copyWith(isFavorite: isFavorite));
  }
}
