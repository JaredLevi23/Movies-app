
import 'package:pagination/src/features/movies/domain/models/favorite_model.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';

abstract class AbstractFavoritesApi {

  Future<String> saveFavorite( { required MovieModel movie, required String uid });
  Future<bool> removeFavorite( { required MovieModel movie, required String uid});
  Future<List<FavoriteModel>> getFavorites({ required String uid });

}