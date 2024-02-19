part of 'favorites_bloc.dart';

enum FavoritesStatus {
  loading,
  loaded,
  error
}

class FavoritesState extends Equatable {

  const FavoritesState({
    this.favorites = const [],
    this.status = FavoritesStatus.loading
  });

  final List<MovieModel> favorites;
  final FavoritesStatus status;

  FavoritesState copyWith({
    List<MovieModel>? favorites,
    FavoritesStatus? status
  })=> FavoritesState(
    favorites: favorites ?? this.favorites,
    status: status ?? this.status
  );
  
  @override
  List<Object> get props => [
    favorites,
    status
  ];
}

