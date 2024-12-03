import 'package:cinemapedia/presentation/bloc/categories_bloc/categories_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GenreTag extends StatelessWidget {
  final String genre;
  final String genreId;
  final bool isSelected;

  const GenreTag({
    super.key,
    required this.genre,
    required this.genreId,
    required this.isSelected,
  });

  void onTagTap(BuildContext context, String genreId, String genreName) {
    context.read<CategoriesBloc>().add(SelectCategoryEvent(genreId, genreName));
    context
        .read<MoviesBloc>()
        .add(GetMoviesByCategoryEvent(genreId.toString()));

    if (GoRouter.of(context).location == '/home/1') {
      context.go('/home/1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTagTap(context, genreId, genre),
      child: Chip(
        backgroundColor:
            isSelected ? Colors.amberAccent.shade100 : Colors.transparent,
        label: Text(
          genre,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.amber,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
