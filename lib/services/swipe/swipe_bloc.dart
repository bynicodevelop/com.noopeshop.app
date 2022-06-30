// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/repositories/swipe_repository.dart';
import 'package:equatable/equatable.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final SwipeRepository swipeRepository;

  SwipeBloc({
    required this.swipeRepository,
  }) : super(SwipeInitialState()) {
    on<OnSwipeUpEvent>((event, emit) {
      print("Swipe up");
    });

    on<OnSwipeDownEvent>((event, emit) {
      print("Swipe down");
    });
  }
}
