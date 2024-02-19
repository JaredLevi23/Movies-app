part of 'counter_view_bloc.dart';

sealed class CounterViewEvent extends Equatable {
  const CounterViewEvent();

  @override
  List<Object> get props => [];
}

class ChangeViewEvent extends CounterViewEvent{
  final int index;
  const ChangeViewEvent({required this.index});
}

class ShowBarEvent extends CounterViewEvent{
  final bool showBar;
  const ShowBarEvent({required this.showBar});
}
