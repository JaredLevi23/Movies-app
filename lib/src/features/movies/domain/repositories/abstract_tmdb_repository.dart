
import 'package:dartz/dartz.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';

abstract class AbstractTmdbRepository{

  Future<Either<GeneralFailure, List<MovieModel>>> getMovieList({ 
    required int page, 
    required String category, 
    required String method 
  });

  Future<Either<GeneralFailure, List<MovieModel>>> discoverList({ 
    required String method, 
    required int page 
  });

  Future<Either<GeneralFailure, MovieModel>>getDetailsById({
    required String idMovie
  });

  Future<Either<GeneralFailure, ReviewsModel>>getReviewsById({
    required String idMovie
  });

}