import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_db_local_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';

part 'populars_event.dart';
part 'populars_state.dart';

class PopularsBloc extends Bloc<PopularsEvent, PopularsState> {

  final AbstractTmdbRepository repository;
  final AbstractDbLocalRepository db;

  PopularsBloc({
    required this.repository,
    required this.db
  }) : super( const PopularsState() ) {

    on<LoadPopularsEvent>( _onLoadPopulars );
    _init();
  }

  _init(){
    add( LoadPopularsEvent() );
  }

  FutureOr<void> _onLoadPopulars(LoadPopularsEvent event, Emitter<PopularsState> emit) async {
      emit( state.copyWith( status: PopulatsStatus.loading ));
      final response = await repository.getMovieList( 
        page: state.page, 
        category: 'popular',
        method: 'movie'
      );

      await response.fold(
        ( l ) async {
          final data = await db.getMovies(category: 'popular', page: '${state.page}' );
          await data.fold(
            (l) async {
              emit( state.copyWith( status: PopulatsStatus.loaded ) );
            }, 
            (r) async {
              emit( state.copyWith(
                page: r.isNotEmpty ? state.page + 1 : state.page,
                movies: [
                  ...state.movies, 
                  ...r
                ],
                status: PopulatsStatus.loaded
              ));
            }
          );
        }, 
        ( r ) async {
          if( r.isNotEmpty ){
            await db.saveMovies( 
              movies: r, 
              category: 'popular', 
              page: '${state.page}' 
            );

            emit(
              state.copyWith(
                movies: [
                  ...state.movies,
                  ...r
                ],
                page: state.page + 1,
                status: PopulatsStatus.loaded
              )
            );
          }else{
            emit( state.copyWith( status: PopulatsStatus.loaded) );
          }
        }
      );
  }
}
