import 'package:com_noopeshop_app/components/cart_button/cart_button_component.dart';
import 'package:com_noopeshop_app/screens/cart_screen.dart';
import 'package:com_noopeshop_app/screens/favotites_screen.dart';
import 'package:com_noopeshop_app/components/feed/current_index/current_index_bloc.dart';
import 'package:com_noopeshop_app/components/feed/feed_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              bottom: 8.0,
            ),
            child: TextButton(
              child: Text(
                "Favoris",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  ),
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
                const CartButtonComponent(),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 0,
        ),
        child: BlocBuilder<CurrentIndexBloc, CurrentIndexState>(
          builder: (context, state) {
            return FeedComponent(
              controller: PageController(
                initialPage: (state as CurrentIndexInitialState).currentIndex,
              ),
            );
          },
        ),
      ),
    );
  }
}
