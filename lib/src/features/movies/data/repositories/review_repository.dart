
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pagination/src/core/helpers/upload.dart';
import 'package:pagination/src/core/network/errors/failure.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/reviews/abstract_review_api.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_reviews_repository.dart';

class ReviewRepository extends AbstractReviewsRepository {

  final AbstractReviewsApi api;
  ReviewRepository({required this.api});

  @override
  Future<Either<GeneralFailure, ReviewModel>> deleteReview({required ReviewModel review, required String uid}) async {
    try {
      final response = await api.deleteReview(review: review, uid: uid);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  Future<Either<GeneralFailure, List<ReviewModel>>> getReviewsByIdMovie({required String id}) async {
    try {
      final response = await api.getReviewsByIdMovie(id: id);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  Future<Either<GeneralFailure, List<ReviewModel>>> getReviewsByUser({required String uid}) async {
    try {
      final response = await api.getReviewsByUser(uid: uid);
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

  @override
  Future<Either<GeneralFailure, ReviewModel>> saveReview({required ReviewModel review, required String uid}) async {
    try {

      if( review.url != null && review.url!.isNotEmpty && !review.url!.startsWith('http') ){
        final url = await UploadFile().uploadFile( File( review.url! ) );
        review = review.copyWith(
          url: url
        );
      }

      final response = await api.saveReview(
        review: review, 
        uid: uid
      );
      return Right( response );
    } catch (e) {
      return Left( GeneralFailure( e.toString() ) );
    }
  }

}