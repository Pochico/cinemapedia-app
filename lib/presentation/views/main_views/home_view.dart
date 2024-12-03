import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_event.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_state.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slider.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          floating: true,
          title: CustomAppbar(),
          forceElevated: true,
          shadowColor: Color.fromARGB(217, 0, 0, 0),
          toolbarHeight: 70,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    BlocBuilder<MoviesBloc, MoviesState>(
                      builder: (context, state) {
                        if (state.nowPlayingMovies.isEmpty ||
                            state.popularMovies.isEmpty ||
                            state.topRatedMovies.isEmpty ||
                            state.upcomingMovies.isEmpty) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return MoviesSlider(
                          movies: state.nowPlayingMovies.length >= 9
                              ? state.nowPlayingMovies.sublist(0, 9)
                              : state.nowPlayingMovies,
                        );
                      },
                    ),
                    BlocBuilder<MoviesBloc, MoviesState>(
                      builder: (context, state) {
                        return MovieHorizontalListview(
                          movies: state.nowPlayingMovies,
                          title: 'En cines',
                          subtitle: 'Mon 20',
                          loadNextPage: () => context
                              .read<MoviesBloc>()
                              .add(LoadNextPageEvent(MovieCategory.nowPlaying)),
                        );
                      },
                    ),
                    BlocBuilder<MoviesBloc, MoviesState>(
                      builder: (context, state) {
                        return MovieHorizontalListview(
                          movies: state.popularMovies,
                          title: 'Popular',
                          loadNextPage: () => context.read<MoviesBloc>().add(
                                LoadNextPageEvent(MovieCategory.popular),
                              ),
                        );
                      },
                    ),
                    BlocBuilder<MoviesBloc, MoviesState>(
                      builder: (context, state) {
                        return MovieHorizontalListview(
                          movies: state.topRatedMovies,
                          title: 'Top Rated',
                          loadNextPage: () => context
                              .read<MoviesBloc>()
                              .add(LoadNextPageEvent(MovieCategory.topRated)),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
