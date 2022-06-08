import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_button_event.dart';
part 'favorite_button_state.dart';

class FavoriteButtonBloc
    extends Bloc<FavoriteButtonEvent, FavoriteButtonState> {
  FavoriteButtonBloc() : super(const FavoriteButtonInitialState()) {
    on<OnFavoriteButtonPressed>((event, emit) {
      emit(FavoriteButtonInitialState(
        isLiked: !(state as FavoriteButtonInitialState).isLiked,
      ));
    });
  }
}
