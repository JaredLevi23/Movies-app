
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/data/data_sources/local/tmdb_db_impl.dart';
import 'package:pagination/src/features/movies/domain/models/favorite_model.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_db_local_repository.dart';

class DBLocalRepository extends AbstractDbLocalRepository{

  final TmdbDB local;

  DBLocalRepository({required this.local});

  @override
  FutureOr<Either<GeneralFailure,int>> deleteMovies({required String category, required String page}) async {
    try {
      final response = await local.deleteMovies(category: category, page: page);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ));
    }
  }

  @override
  FutureOr<Either<GeneralFailure,List<FavoriteModel>>> getFavories({required String uid}) async {
    try {
      final response = await local.getFavories(uid: uid);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  FutureOr<Either<GeneralFailure,List<MovieModel>>> getMovies({required String category, required String page}) async {
    try {
      final response = await local.getMovies(category: category, page: page);
      return Right(response);
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  FutureOr<Either<GeneralFailure,bool>> removeFavorite({required MovieModel movie, required String uid}) async {
    try {
      final response = await local.removeFavorite(movie: movie, uid: uid);
      return Right(response);
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  FutureOr<Either<GeneralFailure,bool>> saveFavorite({required MovieModel? movie, required String? uid}) async {
    try {
      final response = await local.removeFavorite(movie: movie!, uid: uid ?? '');
      return Right(response);
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  FutureOr<Either<GeneralFailure,int>> saveMovies({required List<MovieModel> movies, String? category, String? page}) async {
    try {
      final response = await local.saveMovies(movies: movies);
      return Right(response);
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  FutureOr<Either<GeneralFailure,MovieModel?>> searchMovieById({required String idMovie}) async {
    try {
      final response = await local.searchMovieById(idMovie: idMovie);
      return Right(response);
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }
  
}