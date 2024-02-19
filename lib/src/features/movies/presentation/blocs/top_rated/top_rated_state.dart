part of 'top_rated_bloc.dart';

enum TopRatedStatus{
  loaded,
  loading,
  error
}

class TopRatedState extends Equatable {

  const TopRatedState({
    this.movies = const [],
    this.currentMovie,
    this.status = TopRatedStatus.loading,
    this.page = 1
  });

  final List<MovieModel> movies;
  final MovieModel? currentMovie;
  final TopRatedStatus status;
  final int page;

  TopRatedState copyWith({
    List<MovieModel>? movies,
    MovieModel? currentMovie,
    TopRatedStatus? status,
    int? page
  }) => TopRatedState(
    movies: movies ?? this.movies,
    currentMovie: currentMovie,
    status: status ?? this.status,
    page: page ?? this.page
  );
  
  @override
  List<Object?> get props => [
    movies,
    status,
    currentMovie
  ];
}

