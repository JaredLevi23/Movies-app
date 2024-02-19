part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent{
  final String? uid;
  const LoadFavoritesEvent({required this.uid});
}

class SaveFavoritesEvent extends FavoritesEvent{
  final MovieModel movie;
  final String? uid;
  const SaveFavoritesEvent({required this.movie, this.uid });
}

class RemoveFavoritesEvent extends FavoritesEvent{
  final MovieModel movie;
  final String? uid;
  const RemoveFavoritesEvent({required this.movie, this.uid });
}