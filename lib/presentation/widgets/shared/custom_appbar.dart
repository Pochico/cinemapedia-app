import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Row(
        children: [
          const Spacer(),
          Text(
            'CINEMAPEDIA',
            style: titleStyle?.copyWith(color: colors.onSurface, fontSize: 24),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchMovieDelegate(),
              );
            },
          ),
        ],
      ),
    );
  }
}
