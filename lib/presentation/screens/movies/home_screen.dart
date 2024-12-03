import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_event.dart';
import 'package:cinemapedia/presentation/views/main_views/categories_view.dart';
import 'package:cinemapedia/presentation/views/main_views/favorites_view.dart';
import 'package:cinemapedia/presentation/views/main_views/home_view.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;
  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  static String name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesBloc(MovieRepositoryImpl(MoviedbDatasource()))
        ..add(LoadNextPageEvent(MovieCategory.nowPlaying))
        ..add(LoadNextPageEvent(MovieCategory.popular))
        ..add(LoadNextPageEvent(MovieCategory.topRated))
        ..add(LoadNextPageEvent(MovieCategory.upcoming)),
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ),
        bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
      ),
    );
  }
}
