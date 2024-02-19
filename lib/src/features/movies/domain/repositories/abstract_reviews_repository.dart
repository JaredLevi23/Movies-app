
import 'package:dartz/dartz.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';

abstract class AbstractReviewsRepository {

  Future<Either<GeneralFailure,ReviewModel>>saveReview({ required ReviewModel review, required String uid});
  Future<Either<GeneralFailure,ReviewModel>>deleteReview({ required ReviewModel review, required String uid });
  Future<Either<GeneralFailure,List<ReviewModel>>> getReviewsByIdMovie ( { required String id } );
  Future<Either<GeneralFailure,List<ReviewModel>>> getReviewsByUser ( { required String uid } );

} 