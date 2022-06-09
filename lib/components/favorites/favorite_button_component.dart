import 'dart:ui';

import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButtonComponent extends StatefulWidget {
  final ProductModel productModel;
  final double defaultSize;
  final bool blurButton;

  const FavoriteButtonComponent({
    Key? key,
    required this.productModel,
    this.defaultSize = 16.0,
    this.blurButton = false,
  }) : super(key: key);

  @override
  State<FavoriteButtonComponent> createState() =>
      _FavoriteButtonComponentState();
}

class _FavoriteButtonComponentState extends State<FavoriteButtonComponent> {
  bool _isFavorite = false;

  Widget _button(bool isLiked, {bool isBlur = false}) => CircleAvatar(
        backgroundColor: Colors.white.withOpacity(
          isBlur ? .2 : 1,
        ),
        radius: widget.defaultSize,
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
                  size: widget.defaultSize / .9,
                )
              : Icon(
                  Icons.favorite_border,
                  key: const ValueKey('icon2'),
                  size: widget.defaultSize / .9,
                  color: kBackgroundColor,
                ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteButtonBloc, FavoriteButtonState>(
      listener: (context, state) {
        if ((state as FavoriteButtonInitialState).productModel.id ==
                widget.productModel.id &&
            state.productModel.isFavorite != _isFavorite) {
          setState(() => _isFavorite = state.productModel.isFavorite);
        }
      },
      builder: (context, state) {
        return ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.read<FavoriteButtonBloc>().add(
                    OnFavoriteButtonPressed(
                      productModel: widget.productModel,
                    ),
                  ),
              child: widget.blurButton
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: _button(
                        _isFavorite,
                        isBlur: widget.blurButton,
                      ),
                    )
                  : _button(
                      _isFavorite,
                      isBlur: widget.blurButton,
                    ),
            ),
          ),
        );
      },
    );
  }
}
