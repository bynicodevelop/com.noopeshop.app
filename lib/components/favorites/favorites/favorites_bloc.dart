import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/repositories/favorite_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository favoriteRepository;

  FavoritesBloc({
    required this.favoriteRepository,
  }) : super(const FavoritesInitialState(favorites: [])) {
    favoriteRepository.favorites.listen((favorites) {
      print(favorites);
      add(OnLoadedFavorites(
        favorites: favorites,
      ));
    });

    on<OnLoadFavorites>((event, emit) async {
      await favoriteRepository.loadFavorites();
    });

    on<OnLoadedFavorites>((event, emit) {
      emit(FavoritesInitialState(
        favorites: event.favorites,
      ));
    });
  }
}
