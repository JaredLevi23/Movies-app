import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_db_local_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_favorites_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {

  final AbstractFavoritesRepository api;
  final AbstractDbLocalRepository db;
  final AbstractTmdbRepository tmdbApi;

  FavoritesBloc({
    required this.api,
    required this.db,
    required this.tmdbApi
  }) : super( const FavoritesState() ) {
    on<LoadFavoritesEvent>( _onLoadFavorites );
    on<SaveFavoritesEvent>( _onSaveFavorite );
    on<RemoveFavoritesEvent>( _onRemoveFavorite );
    _init();
  }

  _init(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    add( LoadFavoritesEvent( uid: uid ) );
  }

  FutureOr<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit( state.copyWith( status: FavoritesStatus.loading ) );
    
    final user = FirebaseAuth.instance.currentUser;
    List<MovieModel> movies = [];

    if( event.uid != null && event.uid!.isNotEmpty ){
      final data = await api.getFavorites( uid: user?.uid ?? '' );

      await data.fold(
        (l) async {
          final response = await db.getFavories(uid: user?.uid ?? '');
          response.fold(
            (l) {
              emit( state.copyWith( status: FavoritesStatus.loaded ) );
            }, 
            (r) async {
              for (var favorite in r) {
                final movie = await db.searchMovieById(idMovie: favorite.idMovie );
                await movie.fold(
                  (l) async {
                    final movie = await tmdbApi.getDetailsById(idMovie: favorite.idMovie );
                    movie.fold(
                      (l) => null, 
                      (r) => movies.add( r )
                    );
                  }, 
                  (r) {
                    if( r != null ){
                      movies.add( r );
                    }    
                  }
                );
              
              }
            }
          );
        }, 
        (r) async {
          for (var favorite in r) {
            final movie = await db.searchMovieById(idMovie: favorite.idMovie );
            await movie.fold(
              (l) async {
                final movie = await tmdbApi.getDetailsById(idMovie: favorite.idMovie );
                movie.fold(
                  (l) => null, 
                  (r) => movies.add( r )
                );
              }, 
              (r) {
                if( r != null ){
                  movies.add( r );
                }    
              }
            );
          
          }
        }
      );
    }else{
      final response = await db.getFavories(uid: user?.uid ?? '');
      await response.fold(
        (l) {
          emit( state.copyWith( status: FavoritesStatus.loaded ) );
        }, 
        (r) async {
          for (var favorite in r) {
            final movie = await db.searchMovieById(idMovie: favorite.idMovie );
            await movie.fold(
              (l) async {
                final movie = await tmdbApi.getDetailsById(idMovie: favorite.idMovie );
                movie.fold(
                  (l) => null, 
                  (r) => movies.add( r )
                );
              }, 
              (r) {
                if( r != null ){
                  movies.add( r );
                }    
              }
            );
          
          }
        }
      );
    }

    emit( state.copyWith( 
      status: FavoritesStatus.loaded,
      favorites: movies
    ));

  }



  FutureOr<void> _onSaveFavorite(SaveFavoritesEvent event, Emitter<FavoritesState> emit) async {

    emit( state.copyWith( status: FavoritesStatus.loading ));

    final save = await db.saveFavorite( 
      uid: event.uid ?? '', 
      movie: event.movie 
    );

    await save.fold(
      (l) {
        emit( state.copyWith( status: FavoritesStatus.loaded ));
      }, 
      (r) async {

        if( event.uid != null && event.uid!.isNotEmpty ){
          final res = await api.saveFavorite(movie: event.movie, uid: event.uid! );
          await res.fold((l) async => null, (r) async => null);
        }
        
        emit(
          state.copyWith(
            favorites: [
              ...state.favorites,
              event.movie
            ],
            status: FavoritesStatus.loaded
          )
        );
      }
    );
  }

  FutureOr<void> _onRemoveFavorite(RemoveFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit( state.copyWith( status: FavoritesStatus.loading ));

    final remove = await db.removeFavorite( 
      uid: event.uid ?? '', 
      movie: event.movie 
    );

    await remove.fold(
      (l) async {
        emit(
          state.copyWith(
            status: FavoritesStatus.loaded
          )
        );
      }, 
      (r) async {
        if( event.uid != null && event.uid!.isNotEmpty ){
          final res = await api.removeFavorite(movie: event.movie, uid: event.uid ?? '' );
          res.fold((l) => null, (r) => null);
        }

        List<MovieModel> movies = state.favorites;
        movies.removeWhere( ( e ) => e.id == event.movie.id );
        emit(
          state.copyWith(
            favorites: [
              ...movies
            ],
            status: FavoritesStatus.loaded
          )
        );
      }
      
    );
  }
}
