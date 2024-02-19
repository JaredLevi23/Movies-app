part of 'upcomming_bloc.dart';

sealed class UpcommingEvent extends Equatable {
  const UpcommingEvent();

  @override
  List<Object> get props => [];
}

class LoadUpcommingEvent extends UpcommingEvent{}