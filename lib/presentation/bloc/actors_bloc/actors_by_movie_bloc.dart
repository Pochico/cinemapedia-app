import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'actors_by_movie_event.dart';
part 'actors_by_movie_state.dart';

class ActorsByMovieBloc extends Bloc<ActorsByMovieEvent, ActorsByMovieState> {
  final ActorRepositoryImpl repository;

  ActorsByMovieBloc(this.repository) : super(const ActorsByMovieState()) {
    on<LoadActorsByMovieEvent>(_onLoadActorsByMovie);
  }

  Future<void> _onLoadActorsByMovie(
      LoadActorsByMovieEvent event, Emitter<ActorsByMovieState> emit) async {
    emit(state.copyWith(isLoading: true));
    final actors = await repository.getActorsByMovie(event.movieId);
    emit(state.copyWith(
      actors: List.of(state.actors)..addAll(actors),
      isLoading: false,
    ));
  }
}
