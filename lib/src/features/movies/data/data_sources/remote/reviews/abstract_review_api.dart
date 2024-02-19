
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';

abstract class AbstractReviewsApi {

  Future<ReviewModel>saveReview({ required ReviewModel review, required String uid});
  Future<ReviewModel>deleteReview({ required ReviewModel review, required String uid });
  Future<List<ReviewModel>> getReviewsByIdMovie ( { required String id } );
  Future<List<ReviewModel>> getReviewsByUser ( { required String uid } );

} 