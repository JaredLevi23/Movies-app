
import 'package:equatable/equatable.dart';

class CounterViewState extends Equatable {

  final int currentView;
  final bool showBar;

  const CounterViewState({
    this.currentView = 0,
    this.showBar = true
  });


  CounterViewState copyWith({
    int? currentView,
    bool? showBar
  }) => CounterViewState(
    currentView: currentView ?? this.currentView,
    showBar: showBar ?? this.showBar
  );
  
  @override
  List<Object?> get props => [
    currentView,
    showBar
  ];
}

