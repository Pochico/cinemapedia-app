part of 'actors_by_movie_bloc.dart';

@immutable
abstract class ActorsByMovieEvent {}

class LoadActorsByMovieEvent extends ActorsByMovieEvent {
  final String movieId;
  LoadActorsByMovieEvent(this.movieId);
}
