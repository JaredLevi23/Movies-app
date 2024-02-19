import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination/src/features/movies/presentation/blocs/counter_view/counter_view_state.dart';

part 'counter_view_event.dart';


class CounterViewBloc extends Bloc<CounterViewEvent, CounterViewState> {
  CounterViewBloc() : super( const CounterViewState() ) {
    on<ChangeViewEvent>( _onChangeView );
    on<ShowBarEvent>( _onShowBar );
  }

  FutureOr<void> _onChangeView(ChangeViewEvent event, Emitter<CounterViewState> emit) {
    emit( state.copyWith(
      currentView: event.index,
      showBar: true
    ));
  }

  FutureOr<void> _onShowBar(ShowBarEvent event, Emitter<CounterViewState> emit) {
    emit(
      state.copyWith(
        showBar: event.showBar
      )
    );
  }
}
