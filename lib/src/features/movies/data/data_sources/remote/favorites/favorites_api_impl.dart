import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/favorites/abstract_favorites_api.dart';
import 'package:pagination/src/features/movies/domain/models/favorite_model.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';

class FavoritesApiImpl extends AbstractFavoritesApi{

  final FirebaseFirestore db;

  FavoritesApiImpl({required this.db});

  @override
  Future<bool> removeFavorite({ required MovieModel movie, required String uid }) async {
    try {
        final res = await db.collection( 'favorites' ).
          where("idMovie", isEqualTo: movie.id  ).
          where( 'uid',isEqualTo: uid ).limit(1).get();

          if( res.docs.isNotEmpty ){
            return await db.collection('favorites').doc( res.docs[0].id ).delete().then((value) => true).onError((error, stackTrace) => false);
          }else{
            return false;
          }
    } catch (e) {
        throw Exception( e.toString() );
    }
  }

  @override
  Future<String> saveFavorite({ required MovieModel movie, required String uid }) async {
    try {
      final response = await db.collection('favorites').where( "idMovie", isEqualTo: movie.id  ).where( 'uid',isEqualTo: uid ).get();
      if( response.docs.isEmpty ){
        final res = await db.collection( 'favorites' ).add({ 'idMovie': movie.id, 'uid': uid });
        return res.id;
      }else{
        throw Exception('Failed to load data');
      }
    } catch (e) {
        throw Exception( e.toString() );
    }
  }

  @override
  Future<List<FavoriteModel>> getFavorites({required String uid}) async {
    try {
      final response = await db.collection('favorites').where('uid', isEqualTo: uid ).get();
      if( response.docs.isNotEmpty ){
        return response.docs.map((e) => FavoriteModel.fromJson( e.data() )).toList();
      }else{
        return [];
      }
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

}