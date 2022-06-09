part of 'current_index_bloc.dart';

abstract class CurrentIndexEvent extends Equatable {
  const CurrentIndexEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateCurrentIndexEvent extends CurrentIndexEvent {
  final int currentIndex;

  const OnUpdateCurrentIndexEvent({
    required this.currentIndex,
  });

  @override
  List<Object> get props => [
        currentIndex,
      ];
}
