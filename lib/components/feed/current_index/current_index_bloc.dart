import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'current_index_event.dart';
part 'current_index_state.dart';

class CurrentIndexBloc extends Bloc<CurrentIndexEvent, CurrentIndexState> {
  CurrentIndexBloc() : super(const CurrentIndexInitialState()) {
    on<OnUpdateCurrentIndexEvent>((event, emit) {
      emit(CurrentIndexInitialState(
        currentIndex: event.currentIndex,
      ));
    });
  }
}
