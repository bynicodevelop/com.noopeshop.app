// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/repositories/favorite_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorite_button_event.dart';
part 'favorite_button_state.dart';

class FavoriteButtonBloc
    extends Bloc<FavoriteButtonEvent, FavoriteButtonState> {
  final FavoriteRepository favoriteRepository;

  FavoriteButtonBloc({
    required this.favoriteRepository,
  }) : super(const FavoriteButtonInitialState()) {
    on<OnInitilizeFavoriteButtonEvent>((event, emit) async {
      emit(FavoriteButtonInitialState(
        isLiked: event.productModel.isFavorite,
      ));
    });

    on<OnFavoriteButtonPressed>((event, emit) async {
      final FavoriteStatusEnum isLiked =
          await favoriteRepository.toggleFavorite(
        event.productModel.toJson(),
      );

      emit(FavoriteButtonInitialState(
        isLiked: isLiked == FavoriteStatusEnum.liked,
      ));
    });
  }
}
