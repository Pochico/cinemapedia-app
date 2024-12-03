import 'package:cinemapedia/presentation/bloc/categories_bloc/categories_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_event.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_state.dart';
import 'package:cinemapedia/presentation/widgets/movies/categories_movie_grid_view.dart';
import 'package:cinemapedia/presentation/widgets/movies/genre_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Categories'),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 370,
            flexibleSpace: FlexibleSpaceBar(
              background: _CategoriesTagCloud(),
            ),
          ),
          SliverFillRemaining(
            child: BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                return state.moviesByCategory.isNotEmpty
                    ? CategoriesMovieGridView(movies: state.moviesByCategory)
                    : const Center(child: Text('No movies found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesTagCloud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.selectedCategoryId != null) {
                context
                    .read<MoviesBloc>()
                    .add(GetMoviesByCategoryEvent(state.selectedCategoryId!));
              }

              final categories = state.categories;

              return categories.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Wrap(
                        spacing: 14,
                        runSpacing: 1,
                        children:
                            List.generate(state.categories.length, (index) {
                          return GenreTag(
                            genre: state.categories[index].name,
                            genreId: state.categories[index].id.toString(),
                            isSelected: state.categories[index].isSelected,
                          );
                        }),
                      ),
                    )
                  : const Center(
                      child: Text('No categories found'),
                    );
            },
          ),
        ],
      ),
    );
  }
}
