import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/components/favorites/favorite_button_component.dart';
import 'package:com_noopeshop_app/components/favorites/favorites/favorites_bloc.dart';
import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesComponent extends StatelessWidget {
  const FavoritesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          t(context)!.favoritesAppBar,
          style: Theme.of(context).textTheme.headline6,
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
                    28.0,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              productModel: favorites[index],
                            ),
                          )),
                      child: Column(
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
                                    Image.network(
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
                                          bloc: context
                                              .read<FavoriteButtonBloc>()
                                            ..add(
                                                OnInitilizeFavoriteButtonEvent(
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
                              favorites[index].title,
                              style: Theme.of(context).textTheme.headline2!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : Center(
                  child: Text(
                    t(context)!.notFavoritesYet,
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                );
        },
      ),
    );
  }
}
