import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/components/favorites/favorite_button_component.dart';
import 'package:com_noopeshop_app/models/feed_model.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/widgets/video_play_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel productModel;

  const ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actions: [
          BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
            bloc: context.read<FavoriteButtonBloc>()
              ..add(OnInitilizeFavoriteButtonEvent(
                productModel: productModel,
              )),
            builder: (context, state) {
              return FavoriteButtonComponent(
                productModel: productModel,
                defaultSize: 25.0,
                transparentButton: true,
              );
            },
          )
        ],
      ),
      body: Stack(fit: StackFit.expand, children: [
        productModel.mediaType == MediaTypeEnum.image
            ? Image.asset(
                productModel.media,
                fit: BoxFit.cover,
              )
            : VideoPlayerWidget(
                productModel: productModel,
              ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.15),
          ),
        ),
      ]),
    );
  }
}
