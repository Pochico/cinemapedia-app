import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlider extends StatelessWidget {
  final List<dynamic> movies;

  const MoviesSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
        viewportFraction: .8,
        scale: .9,
        autoplay: false,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 12),
          builder: DotSwiperPaginationBuilder(
            activeSize: 16,
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black54),
                );
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
