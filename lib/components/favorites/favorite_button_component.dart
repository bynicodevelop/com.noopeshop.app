import 'dart:ui';

import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButtonComponent extends StatelessWidget {
  final double defaultSize;
  final bool blurButton;

  const FavoriteButtonComponent({
    Key? key,
    this.defaultSize = 16.0,
    this.blurButton = false,
  }) : super(key: key);

  Widget _button(bool isLiked, {bool isBlur = false}) => CircleAvatar(
        backgroundColor: Colors.white.withOpacity(
          isBlur ? .2 : 1,
        ),
        radius: defaultSize,
        child: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ),
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: child,
          ),
          child: isLiked
              ? Icon(
                  Icons.favorite,
                  key: const ValueKey('icon1'),
                  color: Colors.pink,
                  size: defaultSize / .9,
                )
              : Icon(
                  Icons.favorite_border,
                  key: const ValueKey('icon2'),
                  size: defaultSize / .9,
                  color: kBackgroundColor,
                ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
      builder: (context, state) {
        final isLiked = (state as FavoriteButtonInitialState).isLiked;

        return ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context
                  .read<FavoriteButtonBloc>()
                  .add(OnFavoriteButtonPressed()),
              child: blurButton
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: _button(
                        isLiked,
                        isBlur: blurButton,
                      ),
                    )
                  : _button(
                      isLiked,
                      isBlur: blurButton,
                    ),
            ),
          ),
        );
      },
    );
  }
}
