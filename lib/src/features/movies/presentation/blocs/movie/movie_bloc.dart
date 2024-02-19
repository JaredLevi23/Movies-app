import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_reviews_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  
  final AbstractTmdbRepository service;
  final AbstractReviewsRepository reviews;

  MovieBloc({
    required this.service,
    required this.reviews
  }) : super( const MovieState()) {
    on<SelectedMovieEvent>( _onSelectedMovie );
    on<AddReviewEvent>( _onAddReview );
    on<SaveReviewEvent>( _onSaveReview );
  }

  FutureOr<void> _onSelectedMovie(SelectedMovieEvent event, Emitter<MovieState> emit) async {

    emit( state.copyWith(
      status: MovieStatus.loading,
      currentMovie: event.movie
    ));

    final responseReviews = await service.getReviewsById( idMovie: '${event.movie?.id}'  );
    responseReviews.fold(
      ( a ){
        emit(
          state.copyWith(
            currentMovie: event.movie,
            status: MovieStatus.loaded
          )
        );
      },
      ( b ){
        emit(
          state.copyWith(
            currentMovie: event.movie,
            review: b,
            status: MovieStatus.loaded
          )
        );
      }
    );

    emit( state.copyWith(
      status: MovieStatus.loading,
      currentMovie: event.movie,
      review: state.review
    ));

    if( FirebaseAuth.instance.currentUser != null && event.movie != null){
      emit(
        state.copyWith( status: MovieStatus.loading,
        currentMovie: event.movie,
      ));
      final response = await reviews.getReviewsByIdMovie( id: '${event.movie?.id}' );
      await response.fold(
        (l) async => emit(
          state.copyWith(
            status: MovieStatus.loaded,
            currentMovie: event.movie,
          )
        ), 
        (r) async {
          if( state.review != null ){
            emit(state.copyWith(
              status: MovieStatus.loaded,
              currentMovie: event.movie,
              review: state.review!.copyWith(
                results: [
                  ...state.review?.results ?? [],
                  ...r
                ]
              ))
            );
          }else{
           emit( state.copyWith(
              status: MovieStatus.loaded,
              currentMovie: event.movie,
              review: ReviewsModel(
                results: r
              )
            ));
          }
        }
      );
    }
  }


  FutureOr<void> _onAddReview(AddReviewEvent event, Emitter<MovieState> emit) {
    emit( state.copyWith(
      status: MovieStatus.init,
      currentReview: event.review,
      currentMovie: state.currentMovie,
      review: state.review
    ));
  }

  FutureOr<void> _onSaveReview(SaveReviewEvent event, Emitter<MovieState> emit) async {
    emit(
      state.copyWith(
        status: MovieStatus.loading,
        currentMovie: state.currentMovie,
        review: state.review,
        currentReview: event.review 
      )
    );

    if(  event.review.uid != null &&  event.review.uid!.isNotEmpty ){
      final response = await reviews.saveReview( review: event.review, uid: event.review.uid ?? '' );
      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: MovieStatus.error,
              currentMovie: state.currentMovie,
              review: state.review,
              currentReview: event.review
            )
          );
        } , 
        (r) {
          if( state.review != null ){
            emit(state.copyWith(
              status: MovieStatus.loaded,
              currentMovie: state.currentMovie,
              currentReview: event.review,
              review: state.review?.copyWith(
                results: [
                  r,
                  ...state.review?.results ?? [],
                ]
              )
            ));
          }else{
            emit(state.copyWith(
              status: MovieStatus.loaded,
              currentMovie: state.currentMovie,
              currentReview: event.review,
              review: ReviewsModel(
                results: [
                  r,
                  ...state.review?.results ?? [],
                ]
              )
            ));
          }
        } 
      );
    }else{
      emit(
        state.copyWith(
          currentMovie: state.currentMovie,
          status: MovieStatus.loaded,
          currentReview: event.review,
          review: state.review
        )
      );
    }
  }
}
