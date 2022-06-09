import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/components/favorites/favorite_button_component.dart';
import 'package:com_noopeshop_app/components/favorites/favorites/favorites_bloc.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesComponent extends StatelessWidget {
  const FavoritesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        bloc: context.read<FavoritesBloc>()..add(OnLoadFavorites()),
        builder: (context, state) {
          final List<ProductModel> favorites =
              (state as FavoritesInitialState).favorites;

          return favorites.isNotEmpty
              ? GridView.builder(
                  padding: const EdgeInsets.all(
                    22.0,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12.0,
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    favorites[index].media,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                      right: 10.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: BlocBuilder<FavoriteButtonBloc,
                                          FavoriteButtonState>(
                                        bloc: context.read<FavoriteButtonBloc>()
                                          ..add(OnInitilizeFavoriteButtonEvent(
                                            productModel: favorites[index],
                                          )),
                                        builder: (context, state) {
                                          return FavoriteButtonComponent(
                                            productModel: favorites[index],
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${favorites[index].id} ${favorites[index].title} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .9,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  })
              : const Center(
                  child: Text(
                    'No favorites yet',
                  ),
                );
        },
      ),
    );
  }
}
