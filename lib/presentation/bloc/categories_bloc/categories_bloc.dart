import 'package:cinemapedia/domain/entities/category.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final MoviesBloc moviesBloc;
  final MoviesRepository moviesRepository;

  CategoriesBloc({
    required this.moviesRepository,
    required this.moviesBloc,
  }) : super(const CategoriesState()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onGetCategories(
      GetCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(isLoading: true));
    final categories = await moviesRepository.getCategories();
    emit(state.copyWith(
      categories: categories,
      isLoading: false,
    ));
  }

  Future<void> _onSelectCategory(
      SelectCategoryEvent event, Emitter<CategoriesState> emit) async {
    final updatedCategories = state.categories.map((category) {
      return category.id.toString() == event.id
          ? category.copyWith(isSelected: !category.isSelected)
          : category.copyWith(isSelected: false);
    }).toList();

    emit(state.copyWith(categories: updatedCategories));

    moviesBloc.add(GetMoviesByCategoryEvent(event.id.toString()));
  }
}
