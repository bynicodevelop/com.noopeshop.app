import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/repositories/favorite_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FavoriteRepository favoriteRepository;

  ProductBloc({
    required this.favoriteRepository,
  }) : super(ProductInitialState(
          product: ProductModel.empty(),
        )) {
    on<OnLoadProductEvent>((event, emit) async {
      final ProductModel productModel = await favoriteRepository
          .getProductModel({"id": event.productId}).first;

      emit(ProductInitialState(
        product: productModel,
      ));
    });
  }
}
