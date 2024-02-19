part of 'movie_bloc.dart';

enum MovieStatus {
  loading,
  loaded,
  error,
  init
}

class MovieState extends Equatable {

  const MovieState({
    this.currentMovie,
    this.review,
    this.currentReview,
    this.status = MovieStatus.loaded
  });

  final MovieModel? currentMovie;
  final ReviewsModel? review;
  final ReviewModel? currentReview;
  final MovieStatus status;

  MovieState copyWith({
    MovieModel? currentMovie,
    ReviewsModel? review,
    MovieStatus? status,
    ReviewModel? currentReview
  })=> MovieState(
    currentMovie: currentMovie,
    review: review,
    status: status ?? this.status,
    currentReview: currentReview
  );
  
  @override
  List<Object?> get props => [
    currentMovie,
    review,
    currentReview,
    status
  ];
}

