
import 'package:flutter/material.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/presentation/widgets/movie_image.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.black),
      width: 150,
      height: 265,
      child: Column(
        children: [
          Expanded(child: MovieImage(path: movie.posterPath ?? '')),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              movie.title!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
