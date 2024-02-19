
import 'dart:async';

import 'package:pagination/src/features/movies/domain/models/favorite_model.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';

abstract class AbstractTmdbDB {

  FutureOr<bool> removeFavorite({required MovieModel movie, required String uid});
  FutureOr<bool> saveFavorite({required MovieModel? movie, required String? uid});
  FutureOr<MovieModel?> searchMovieById({ required String idMovie });
  FutureOr<List<FavoriteModel>> getFavories({ required String uid });
  FutureOr<List<MovieModel>> getMovies({ required String category, required String page });
  FutureOr<int> saveMovies({ required List<MovieModel> movies, String? category, String? page });
  FutureOr<int> deleteMovies({ required String category, required String page });

}