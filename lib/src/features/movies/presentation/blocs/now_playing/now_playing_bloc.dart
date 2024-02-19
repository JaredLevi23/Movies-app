import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_db_local_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {

  final AbstractTmdbRepository repository;
  final AbstractDbLocalRepository db;

  NowPlayingBloc({
    required this.repository,
    required this.db
  }) : super( const NowPlayingState() ) {
    on<LoadNowPlayingEvent>( _onLoadNowPlaying );
    _init();
  }

  _init(){
    add( LoadNowPlayingEvent() );
  }

  FutureOr<void> _onLoadNowPlaying(LoadNowPlayingEvent event, Emitter<NowPlayingState> emit) async {
    
      emit( state.copyWith( status: NowPlayingStatus.loading ));

      final response = await repository.getMovieList( 
        page: state.page, 
        category: 'now_playing',
        method: 'movie'
      );

      await response.fold(
        ( l ) async {
          final data = await db.getMovies(category: 'now_playing', page: '${state.page}' );
          await data.fold(
            (l) async {
              emit( state.copyWith( status: NowPlayingStatus.loaded ) );
            }, 
            (r) async {
              emit( state.copyWith(
                page: r.isNotEmpty ? state.page + 1 : state.page,
                movies: [
                  ...state.movies, 
                  ...r,
                ],
                status: NowPlayingStatus.loaded
              ));
            }
          );
        }, 
        ( r ) async {
          if( r.isNotEmpty ){

            await db.saveMovies( 
              movies: r, 
              category: 'now_playing', 
              page: '${state.page}' 
            );

            emit(
              state.copyWith(
                movies: [
                  ...state.movies,
                  ...r
                ],
                page: state.page + 1,
                status: NowPlayingStatus.loaded
              )
            );
          }else{
            emit( state.copyWith( status: NowPlayingStatus.loaded) );
          }
        }
      );
  }
}
