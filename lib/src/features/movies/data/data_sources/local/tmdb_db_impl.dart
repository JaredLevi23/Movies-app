import 'dart:async';
import 'dart:convert';

import 'package:pagination/src/features/movies/data/data_sources/local/abstract_tmdb_db.dart';
import 'package:pagination/src/features/movies/domain/models/favorite_model.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';

class TmdbDB extends AbstractTmdbDB{

  final Database database;

  TmdbDB({required this.database});
  
  @override
  FutureOr<bool> removeFavorite({required MovieModel movie, required String uid}) async {
    try {
      final data = await database.delete('favorites', where: 'idMovie=? and uid=?', whereArgs: [ movie.id, uid ] );
      if( data > 0 ){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

@override
  FutureOr<bool> saveFavorite({required MovieModel? movie, required String? uid}) async {
    try {
      final data = await database.insert('favorites', { 'idMovie': '${movie?.id ?? ''}', 'uid': uid ?? '' });
      if( data > 0 ){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

@override
  FutureOr<MovieModel?> searchMovieById({ required String idMovie }) async {
    try {
      final data = await database.query('movies', where: 'id=?', whereArgs: [ idMovie ]);
      if( data.isNotEmpty ){
        return MovieModel.fromMap( data[0] );
      }else{
        throw Exception( 'Fail to load data' );
      }
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

@override
  FutureOr<List<FavoriteModel>> getFavories({ required String uid }) async {
    try {
      final data = await database.query('favorites', where: 'uid=?', whereArgs: [ uid ]);
      if( data.isNotEmpty ){
        return data.isEmpty 
        ? []
        : data.map(( e ){ 
          return FavoriteModel.fromRawJson( json.encode( e ) );
        } ).toList();
      }else{
        throw Exception('Fail to load data');
      }
    } catch (e) {
      throw Exception('Fail to load data');
    }
  }


@override
  FutureOr<List<MovieModel>> getMovies({ required String category, required String page }) async {
    try {
      final response = await database.query('movies', where: 'category=? and page=?', whereArgs: [ category, page ]);
      return response.isEmpty 
      ? []
      : response.map((e) => MovieModel.fromMap( e )).toList() ;
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

@override
  FutureOr<int> saveMovies({ required List<MovieModel> movies, String? category, String? page }) async {
    await deleteMovies(category: category ?? '', page: page ?? '');
    try {
      final batch = database.batch();
      for (var element in movies) {
        batch.insert( 'movies', element.toJson( category: category, page: page ));
      }
      final res = await batch.commit();
      return res.length;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

@override
  FutureOr<int> deleteMovies({ required String category, required String page }) async {
    try {
      final response = await database.delete(
        'movies', 
        where: 'category=? and page=?', 
        whereArgs: [ category, page ]
      );
      return response;
    } catch (e) {
      throw Exception( e.toString() );
    }
  }
}