
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';
import 'package:pagination/src/features/movies/domain/models/tmdb_model.dart';

abstract class AbstractTmdbApi{

  Future<TmdbModel> getMovieList({ 
    required int page, 
    required String category, 
    required String method 
  });

  Future<TmdbModel> discoverList({ 
    required String method, 
    required int page 
  });

  Future<MovieModel> getDetailsById({
    required String idMovie
  });

  Future<ReviewsModel> getReviewsById({
    required String idMovie
  });

}