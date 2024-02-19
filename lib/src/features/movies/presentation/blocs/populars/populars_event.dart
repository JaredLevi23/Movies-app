part of 'populars_bloc.dart';

sealed class PopularsEvent extends Equatable {
  const PopularsEvent();

  @override
  List<Object> get props => [];
}

class LoadPopularsEvent extends PopularsEvent{}