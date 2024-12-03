part of 'actors_by_movie_bloc.dart';

class ActorsByMovieState extends Equatable {
  final List<Actor> actors;
  final bool isLoading;

  const ActorsByMovieState({
    this.actors = const [],
    this.isLoading = false,
  });

  ActorsByMovieState copyWith({
    List<Actor>? actors,
    bool? isLoading,
  }) {
    return ActorsByMovieState(
      actors: actors ?? this.actors,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        actors,
        isLoading,
      ];
}
