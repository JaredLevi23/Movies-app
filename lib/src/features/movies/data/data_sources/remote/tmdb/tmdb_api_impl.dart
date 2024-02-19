
import 'package:pagination/src/core/helpers/helpers.dart';
import 'package:pagination/src/core/utils/constants/network_constant.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/tmdb/abstract_tmdb_api.dart';
import 'package:http/http.dart' as http;
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';
import 'package:pagination/src/features/movies/domain/models/tmdb_model.dart';

class TmdbApiImpl extends AbstractTmdbApi{

  @override
  Future<TmdbModel> getMovieList( { required int page, required String category, required String method } ) async {
    try {
      final response = await http.get(
        Uri.parse('${ getTmdbUrl() }/$method/$category?page=$page&language=es-MX'),
        headers: Helpers.getHeaders()
      );

      if( response.statusCode == 200 ){
        return TmdbModel.fromRawJson( response.body );
      }else{
        throw Exception('Fail load data');
      }
    } catch (e) {
        throw Exception( e.toString() );
    }
  }

  @override
  Future<TmdbModel> discoverList({ required String method, required int page }) async {
    try {
      final response = await http.get(
        Uri.parse( '${ getTmdbUrl() }/discover/$method?include_adult=false&include_video=false&page=$page&sort_by=popularity.desc&language=es-MX' ),
        headers: Helpers.getHeaders()
      );

      if( response.statusCode == 200 ){
        return TmdbModel.fromRawJson( response.body );
      }else{
        throw Exception('Failed to load data');
      }

    } catch (e) {
      throw Exception( e.toString() );
    }
  }

  @override
  Future<MovieModel> getDetailsById({required String idMovie}) async {
    try {
      final response = await http.get(
        Uri.parse( '${ getTmdbUrl() }/movie/$idMovie?language=es-MX' ),
        headers: Helpers.getHeaders()
      );
      if( response.statusCode == 200 ){
        return MovieModel.fromRawJson( response.body );
      }else{
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

  @override
  Future<ReviewsModel> getReviewsById({required String idMovie}) async {
    try {
      final response = await http.get(
        Uri.parse( '${ getTmdbUrl() }/movie/$idMovie/reviews?language=es-MX&page=1' ),
        headers: Helpers.getHeaders()
      );

      if( response.statusCode == 200 ){
        return ReviewsModel.fromRawJson( response.body );
      }else{
        throw Exception( 'Fail to load data' );
      }
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

}