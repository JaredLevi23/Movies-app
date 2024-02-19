part of 'now_playing_bloc.dart';

enum NowPlayingStatus{
  loaded,
  loading,
  error
}

class NowPlayingState extends Equatable {

  const NowPlayingState({
    this.movies = const [],
    this.currentMovie,
    this.status = NowPlayingStatus.loading,
    this.page = 1
  });

  final List<MovieModel> movies;
  final MovieModel? currentMovie;
  final NowPlayingStatus status;
  final int page;

  NowPlayingState copyWith({
    List<MovieModel>? movies,
    MovieModel? currentMovie,
    NowPlayingStatus? status,
    int? page
  }) => NowPlayingState(
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

