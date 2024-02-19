
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/domain/models/favorite_model.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';

abstract class AbstractDbLocalRepository{

  FutureOr<Either<GeneralFailure, bool>> removeFavorite({required MovieModel movie, required String uid});
  FutureOr<Either<GeneralFailure, bool>> saveFavorite({required MovieModel? movie, required String? uid});
  FutureOr<Either<GeneralFailure, MovieModel?>> searchMovieById({ required String idMovie });
  FutureOr<Either<GeneralFailure, List<FavoriteModel>>> getFavories({ required String uid });
  FutureOr<Either<GeneralFailure, List<MovieModel>>> getMovies({ required String category, required String page });
  FutureOr<Either<GeneralFailure, int>> saveMovies({ required List<MovieModel> movies, String? category, String? page });
  FutureOr<Either<GeneralFailure, int>> deleteMovies({ required String category, required String page });  

}