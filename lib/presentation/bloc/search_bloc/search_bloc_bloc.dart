import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/bloc/search_bloc/search_bloc_event.dart';
import 'package:cinemapedia/presentation/bloc/search_bloc/search_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MoviesRepository repository;

  SearchBloc(this.repository) : super(const SearchState()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchInitial(query));
      emit(SearchLoading());

      try {
        final movies = await repository.searchMovie(query);

        emit(SearchLoaded(movies));
      } catch (e) {
        emit(const SearchError(
            'No se pudieron cargar los resultados de búsqueda'));
      }
    });
  }
}
