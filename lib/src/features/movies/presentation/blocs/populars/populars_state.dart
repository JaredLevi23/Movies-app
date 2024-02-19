part of 'populars_bloc.dart';

enum PopulatsStatus{
  loaded,
  loading,
  error
}

class PopularsState extends Equatable {

  const PopularsState({
    this.movies = const [],
    this.currentMovie,
    this.status = PopulatsStatus.loading,
    this.page = 1
  });

  final List<MovieModel> movies;
  final MovieModel? currentMovie;
  final PopulatsStatus status;
  final int page;

  PopularsState copyWith({
    List<MovieModel>? movies,
    MovieModel? currentMovie,
    PopulatsStatus? status,
    int? page
  }) => PopularsState(
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

