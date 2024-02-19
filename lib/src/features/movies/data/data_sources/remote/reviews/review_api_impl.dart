
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/reviews/abstract_review_api.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';

class ReviewApiImpl extends AbstractReviewsApi{

  final FirebaseFirestore db;
  ReviewApiImpl({required this.db});

  @override
  Future<ReviewModel> deleteReview({required ReviewModel review, required String uid}) async {
    try {
      await db.collection('reviews').doc( review.id ).delete();
      return review;
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

  @override
  Future<List<ReviewModel>> getReviewsByIdMovie({required String id}) async {
    try {
      final response = await db.collection('reviews').where( "id", isEqualTo: id  ).get();
      return response.docs.map((e) => ReviewModel.fromJson( e.data() )).toList();
    } catch (e) {
      throw Exception( e );
    }
  }

  @override
  Future<List<ReviewModel>> getReviewsByUser({required String uid}) async {
    try {
      final response = await db.collection('reviews').where( 'uid', isEqualTo: uid ).get();
      return response.docs.map((e) => ReviewModel.fromJson( e.data() )).toList();
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

  @override
  Future<ReviewModel> saveReview({required ReviewModel review, required String uid}) async {
    try {
      final response = await db.collection('reviews').add( review.toJson() );
      return review.copyWith(
        id: response.id
      );
    } catch (e) {
      throw Exception( e.toString() );
    }
  }

}