import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_db_local_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_reviews_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {

  final AbstractTmdbRepository service;
  final AbstractDbLocalRepository db;
  final AbstractReviewsRepository reviewsRepository;

  MoviesBloc({ required this.service, required this.db, required this.reviewsRepository }) : super( const MoviesState() ) {
    on<LoadMoviesEvent>( _onLoadMovies );
    on<LoadReviews>( _onLoadReviews );
    on<AddReviewListEvent>( onAddReviewList );
    _init();
  }

  _init(){
    add( LoadMoviesEvent() );
  }

  FutureOr<void> _onLoadMovies(LoadMoviesEvent event, Emitter<MoviesState> emit) async {
    emit( state.copyWith( status: MoviesStatus.loading ));
    
    final response = await service.discoverList(
      method: 'movie',
      page: state.page
    );

    await response.fold(
      (l) async {
        final data = await db.getMovies(category: 'movie', page: '${state.page}' );
        await data.fold(
          (l) async {
            emit(
              state.copyWith(
                status: MoviesStatus.loaded
              )
            );
          }, 
          (r) async {
            emit( state.copyWith(
              page: r.isNotEmpty ? state.page + 1 : state.page,
              movies: [
                ...state.movies, 
                ...r
              ],
              status: MoviesStatus.loaded
            ));
          }
        );
        
      }, 
      (r) async {

        await db.saveMovies( 
          movies: r, 
          category: 'movie', 
          page: '${state.page}' 
        );
          
        emit(
          state.copyWith(
            page: r.isNotEmpty ? state.page + 1 : state.page,
            movies: [ ...state.movies, ...r ],
            status: MoviesStatus.loaded
          )
        );
      }
    );
  }

  FutureOr<void> _onLoadReviews(LoadReviews event, Emitter<MoviesState> emit) async {

    emit( state.copyWith( status: MoviesStatus.loading ) );
    final reviews = await reviewsRepository.getReviewsByUser(uid: event.uid );

    reviews.fold(
      (l) => emit( state.copyWith( reviews: [] ) ), 
      (r) => emit( state.copyWith( reviews: r ) )
    );

  }

  FutureOr<void> onAddReviewList(AddReviewListEvent event, Emitter<MoviesState> emit) {
    emit(
      state.copyWith(
        reviews: [
          ...state.reviews,
          event.review
        ]
      )
    );
  }
}
