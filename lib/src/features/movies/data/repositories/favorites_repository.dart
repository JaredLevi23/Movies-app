
import 'package:dartz/dartz.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/favorites/abstract_favorites_api.dart';
import 'package:pagination/src/features/movies/domain/models/favorite_model.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_favorites_repository.dart';

class FavoritesRepository extends AbstractFavoritesRepository{

  final AbstractFavoritesApi api;

  FavoritesRepository({required this.api});

  @override
  Future<Either<GeneralFailure, List<FavoriteModel>>> getFavorites({required String uid}) async {
    try {
      final response = await api.getFavorites(uid: uid);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  Future<Either<GeneralFailure, bool>> removeFavorite({required MovieModel movie, required String uid}) async {
    try {
      final response = await api.removeFavorite(movie: movie, uid: uid);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
    
  }

  @override
  Future<Either<GeneralFailure, String>> saveFavorite({required MovieModel movie, required String uid}) async {
    try {
      final response = await api.saveFavorite(movie: movie, uid: uid);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
    
  }
  

}