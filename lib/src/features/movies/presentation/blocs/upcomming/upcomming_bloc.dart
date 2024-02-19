import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_db_local_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';

part 'upcomming_event.dart';
part 'upcomming_state.dart';

class UpcommingBloc extends Bloc<UpcommingEvent, UpcommingState> {

  final AbstractTmdbRepository repository;
  final AbstractDbLocalRepository db;

  UpcommingBloc({
    required this.repository,
    required this.db
  }) : super( const UpcommingState() ) {
    on<LoadUpcommingEvent>( _onLoadUpcomming );
    _init();
  }

  _init(){
    add( LoadUpcommingEvent() );
  }

  FutureOr<void> _onLoadUpcomming(LoadUpcommingEvent event, Emitter<UpcommingState> emit) async {
    
      emit( state.copyWith( status: UpcommingStatus.loading ));
      final response = await repository.getMovieList( 
        page: state.page, 
        category: 'upcoming',
        method: 'movie'
      );

      await response.fold(
        ( l ) async {
          final data = await db.getMovies(category: 'upcoming', page: '${state.page}' );

          await data.fold(
            (l) async {

            }, 
            (r) async {
              emit( state.copyWith(
                page: r.isNotEmpty ? state.page + 1 : state.page,
                movies: [
                  ...state.movies, 
                  ...r,

                ],
                status: UpcommingStatus.loaded
              ));
            }
          );

        }, 
        ( r ) async {
          if( r.isNotEmpty ){

            await db.saveMovies( 
              movies: r, 
              category: 'upcoming', 
              page: '${state.page}' 
            );

            emit(
              state.copyWith(
                movies: [
                  ...state.movies,
                  ...r
                ],
                page: state.page + 1,
                status: UpcommingStatus.loaded
              )
            );
          }else{
            emit( state.copyWith( status: UpcommingStatus.loaded) );
          }
        }
      );
  }
}
