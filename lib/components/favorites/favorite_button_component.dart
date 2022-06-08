import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButtonComponent extends StatelessWidget {
  const FavoriteButtonComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteButtonBloc>(
      create: (context) => FavoriteButtonBloc(),
      child: BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
        builder: (context, state) {
          final isLiked = (state as FavoriteButtonInitialState).isLiked;

          return ClipOval(
            child: Material(
              child: InkWell(
                onTap: () => context
                    .read<FavoriteButtonBloc>()
                    .add(OnFavoriteButtonPressed()),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16.0,
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                    size: 16.0 / .9,
                    color: isLiked ? Colors.pink : kBackgroundColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
