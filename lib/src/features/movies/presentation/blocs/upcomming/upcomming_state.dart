part of 'upcomming_bloc.dart';

enum UpcommingStatus{
  loaded,
  loading,
  error
}

class UpcommingState extends Equatable {

  const UpcommingState({
    this.movies = const [],
    this.currentMovie,
    this.status = UpcommingStatus.loading,
    this.page = 1
  });

  final List<MovieModel> movies;
  final MovieModel? currentMovie;
  final UpcommingStatus status;
  final int page;

  UpcommingState copyWith({
    List<MovieModel>? movies,
    MovieModel? currentMovie,
    UpcommingStatus? status,
    int? page
  }) => UpcommingState(
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

