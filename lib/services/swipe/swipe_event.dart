part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class OnSwipeUpEvent extends SwipeEvent {}

class OnSwipeDownEvent extends SwipeEvent {}
