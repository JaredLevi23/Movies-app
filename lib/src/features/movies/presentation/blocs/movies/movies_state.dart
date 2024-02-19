part of 'movies_bloc.dart';

enum MoviesStatus{
  loaded,
  loading,
  error
}

class MoviesState extends Equatable {

  const MoviesState({
    this.movies = const [],
    this.reviews = const [],
    this.currentMovie,
    this.status = MoviesStatus.loading,
    this.page = 1
  });

  final List<MovieModel> movies;
  final List<ReviewModel> reviews;
  final MovieModel? currentMovie;
  final MoviesStatus status;
  final int page;

  MoviesState copyWith({
    List<MovieModel>? movies,
    MovieModel? currentMovie,
    MoviesStatus? status,
    int? page,
    List<ReviewModel>? reviews
  }) => MoviesState(
    movies: movies ?? this.movies,
    currentMovie: currentMovie,
    status: status ?? this.status,
    page: page ?? this.page,
    reviews: reviews ?? this.reviews
  );
  
  @override
  List<Object?> get props => [
    movies,
    status,
    currentMovie,
    reviews,
    page
  ];
}

