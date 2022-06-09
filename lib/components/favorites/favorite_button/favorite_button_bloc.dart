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
  }) : super(FavoriteButtonInitialState(productModel: ProductModel.empty())) {
    on<OnInitilizeFavoriteButtonEvent>((event, emit) async {
      favoriteRepository.getProductModel({
        "id": event.productModel.id,
        "isFavorite": event.productModel.isFavorite,
      }).listen((productModel) {
        add(OnUpdateFavoriteButtonEvent(
          productModel: productModel,
        ));
      });
    });

    on<OnUpdateFavoriteButtonEvent>((event, emit) async {
      emit(FavoriteButtonInitialState(
        productModel: event.productModel,
      ));
    });

    on<OnFavoriteButtonPressed>((event, emit) async {
      print(
          "OnFavoriteButtonPressed event.productModel.id: ${event.productModel.id}");
      final ProductModel productModel = await favoriteRepository.toggleFavorite(
        event.productModel.toJson(),
      );

      emit(FavoriteButtonInitialState(
        productModel: productModel,
      ));
    });
  }
}
