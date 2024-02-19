part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadMoviesEvent extends MoviesEvent{}

class LoadReviews extends MoviesEvent{
  final String uid;
  const LoadReviews({required this.uid});
}

class AddReviewListEvent extends MoviesEvent{
  final ReviewModel review;
  const AddReviewListEvent({required this.review});
}