part of 'current_index_bloc.dart';

abstract class CurrentIndexState extends Equatable {
  const CurrentIndexState();

  @override
  List<Object> get props => [];
}

class CurrentIndexInitialState extends CurrentIndexState {
  final int currentIndex;

  const CurrentIndexInitialState({
    this.currentIndex = 0,
  });

  @override
  List<Object> get props => [
        currentIndex,
      ];
}
