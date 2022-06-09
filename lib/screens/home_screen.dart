import 'package:com_noopeshop_app/components/favorites/favotites_component.dart';
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
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            50.0,
          ),
          child: BlocBuilder<CurrentIndexBloc, CurrentIndexState>(
            builder: (context, state) {
              return PageView(
                controller: _pageController,
                onPageChanged: (int index) =>
                    setState(() => _currentIndex = index),
                children: [
                  FeedComponent(
                    controller: PageController(
                      initialPage:
                          (state as CurrentIndexInitialState).currentIndex,
                    ),
                  ),
                  const FavoritesComponent(),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );

          setState(() => _currentIndex = index);
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
            ),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
