import 'package:dartz/dartz.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/domain/models/favorite_model.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';

abstract class AbstractFavoritesRepository {

  Future<Either<GeneralFailure, String>> saveFavorite( { required MovieModel movie, required String uid });
  Future<Either<GeneralFailure, bool>> removeFavorite( { required MovieModel movie, required String uid});
  Future<Either<GeneralFailure, List<FavoriteModel>>> getFavorites({ required String uid });

}