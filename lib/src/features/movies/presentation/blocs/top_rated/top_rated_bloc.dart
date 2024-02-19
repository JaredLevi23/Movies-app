import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_db_local_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {

  final AbstractTmdbRepository repository;
  final AbstractDbLocalRepository db;

  TopRatedBloc({
    required this.repository,
    required this.db
  }) : super( const TopRatedState() ) {
    on<LoadTopRatedEvent>( _onLoadTopRated );
    _init();
  }

  _init(){
    add( LoadTopRatedEvent() );
  }

  FutureOr<void> _onLoadTopRated(LoadTopRatedEvent event, Emitter<TopRatedState> emit) async {

      emit( state.copyWith( status: TopRatedStatus.loading ));
      final response = await repository.getMovieList( 
        page: state.page, 
        category: 'top_rated',
        method: 'movie'
      );

      await response.fold(
        (l) async {
          final data = await db.getMovies(category: 'top_rated', page: '${state.page}' );
          data.fold(
            (l) async {
              emit( state.copyWith( status: TopRatedStatus.loaded ) );
            }, 
            (r) async {
              emit( state.copyWith(
                page: r.isNotEmpty ? state.page + 1 : state.page,
                movies: [
                  ...state.movies, 
                  ...r,

                ],
                status: TopRatedStatus.loaded
              ));
            }
          );
        }, 
        (r) async {
          if( r.isNotEmpty ){
            
            await db.saveMovies( 
              movies: r, 
              category: 'top_rated', 
              page: '${state.page}' 
            );

            emit(
              state.copyWith(
                movies: [
                  ...state.movies,
                  ...r
                ],
                page: state.page + 1,
                status: TopRatedStatus.loaded
              )
            );
          }else{
            emit( state.copyWith( status: TopRatedStatus.loaded) );
          }
        }
      );
  }
}
