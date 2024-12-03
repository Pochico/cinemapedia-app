part of 'local_storage_isar_bloc_bloc.dart';

class LocalStorageIsarBlocState extends Equatable {
  final List<Movie> favoriteMovies;
  final bool isFavorite;
  final bool isLoading;

  const LocalStorageIsarBlocState({
    required this.isFavorite,
    this.favoriteMovies = const [],
    this.isLoading = false,
  });

  LocalStorageIsarBlocState copyWith({
    List<Movie>? favoriteMovies,
    bool? isFavorite,
    bool? isLoading,
  }) {
    return LocalStorageIsarBlocState(
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      isLoading: isLoading ?? this.isLoading,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [
        favoriteMovies,
        isLoading,
        isFavorite,
      ];
}
