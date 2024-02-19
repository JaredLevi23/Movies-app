part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class SelectedMovieEvent extends MovieEvent{
  final MovieModel? movie;
  const SelectedMovieEvent({required this.movie});
}

class AddReviewEvent extends MovieEvent{
  final ReviewModel review;
  const AddReviewEvent({required this.review});
}

class SaveReviewEvent extends MovieEvent{
  final ReviewModel review;
  final String? uid;
  const SaveReviewEvent({required this.review, this.uid});
}



