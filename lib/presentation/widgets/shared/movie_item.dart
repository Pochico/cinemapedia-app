import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            height: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GestureDetector(
                onTap: () => context.push('/movie/${movie.id}'),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),

          // Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
            ),
          ),

          const SizedBox(height: 5),

          // Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                const Icon(
                  Icons.star_half_rounded,
                  color: Colors.yellow,
                ),
                const SizedBox(width: 5),
                Text(
                  HumanFormats.number(movie.voteAverage),
                  style: const TextStyle(
                      color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
