import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/components/favorites/favorite_button_component.dart';
import 'package:com_noopeshop_app/components/product_bottom_sheet/product_bottom_sheet_component.dart';
import 'package:com_noopeshop_app/components/slider/slider_component.dart';
import 'package:com_noopeshop_app/models/feed_model.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/widgets/video_play_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final int _currentIndex = 0;

  Widget _bulletPoint(MapEntry<int, String> entry, int currentIndex) =>
      SizedBox(
        height: 10,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 150,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 4.0,
          ),
          height: entry.key == currentIndex ? 10 : 8.0,
          width: entry.key == currentIndex ? 12 : 8.0,
          decoration: BoxDecoration(
            boxShadow: [
              entry.key == currentIndex
                  ? BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.72),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                    )
                  : const BoxShadow(
                      color: Colors.transparent,
                    )
            ],
            shape: BoxShape.circle,
            color: entry.key == currentIndex
                ? Colors.blueGrey
                : const Color(0XFFEAEAEA),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actions: [
          BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
            bloc: context.read<FavoriteButtonBloc>()
              ..add(OnInitilizeFavoriteButtonEvent(
                productModel: widget.productModel,
              )),
            builder: (context, state) {
              return FavoriteButtonComponent(
                productModel: widget.productModel,
                defaultSize: 25.0,
                transparentButton: true,
              );
            },
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          widget.productModel.mediaType == MediaTypeEnum.image
              ? SliderComponent(
                  productModel: widget.productModel,
                )
              : VideoPlayerWidget(
                  productModel: widget.productModel,
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ProductBottomSheetComponent(
              productModel: widget.productModel,
            ),
          )
        ],
      ),
    );
  }
}
