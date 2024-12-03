import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/infrastructure/datasources/local_isar_datasource.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/presentation/bloc/categories_bloc/categories_bloc.dart';
import 'package:cinemapedia/presentation/bloc/local_storage_isar_bloc/local_storage_isar_bloc_bloc.dart';
import 'package:cinemapedia/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:cinemapedia/presentation/bloc/search_bloc/search_bloc_bloc.dart';
import 'package:cinemapedia/presentation/bloc/search_bloc/search_bloc_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SearchBloc(MovieRepositoryImpl(MoviedbDatasource()))
                ..add(const OnQueryChanged('')),
        ),
        BlocProvider(
          create: (context) => LocalStorageIsarBloc(
              LocalStorageRepositoryImpl(LocalIsarDatasource()))
            ..add(LoadFavoriteMoviesIsarEvent(0)),
        ),
        BlocProvider(
            create: (context) => CategoriesBloc(
                  moviesBloc:
                      MoviesBloc(MovieRepositoryImpl(MoviedbDatasource())),
                  moviesRepository: MovieRepositoryImpl(MoviedbDatasource()),
                )..add(GetCategoriesEvent()))
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(isDarkMode: true),
      ),
    );
  }
}
