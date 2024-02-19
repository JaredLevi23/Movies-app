
import 'package:dartz/dartz.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/tmdb/tmdb_api_impl.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';

class TmdbRepository extends AbstractTmdbRepository{

  final TmdbApiImpl api;

  TmdbRepository({
    required this.api
  });

  @override
  Future<Either<GeneralFailure, List<MovieModel>>> discoverList({required String method, required int page}) async {
    try {
      final response = await api.discoverList(method: method, page: page);
      return Right( response.results ?? [] );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ));
    }
  }

  @override
  Future<Either<GeneralFailure, List<MovieModel>>> getMovieList({required int page, required String category, required String method}) async{
    try {
      final response = await api.getMovieList(page: page, category: category, method: method);
      return Right( response.results ?? [] );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  Future<Either<GeneralFailure, MovieModel>> getDetailsById({required String idMovie}) async{
    try {
      final response = await api.getDetailsById(idMovie: idMovie);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  Future<Either<GeneralFailure, ReviewsModel>> getReviewsById({required String idMovie}) async {
    try {
      final response = await api.getReviewsById(idMovie: idMovie);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

}