import 'package:cached_network_image/cached_network_image.dart';
import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:flutter/material.dart';

class SliderComponent extends StatefulWidget {
  final ProductModel productModel;

  const SliderComponent({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<SliderComponent> createState() => _SliderComponentState();
}

class _SliderComponentState extends State<SliderComponent> {
  int _currentIndex = 0;

  late List<CachedNetworkImage> _media;

  @override
  void initState() {
    super.initState();

    _media = widget.productModel.media
        .map((e) => CachedNetworkImage(
              imageUrl: e,
              fit: BoxFit.cover,
            ))
        .toList();
  }

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
                      color: Colors.amber.withOpacity(0.72),
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
                ? Colors.amber
                : const Color(0XFFEAEAEA),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (value) => setState(
            () => _currentIndex = value,
          ),
          children: _media
              .map((media) => Stack(
                    fit: StackFit.expand,
                    children: [
                      media,
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [.01, .4],
                            colors: [
                              kBackgroundColor.withOpacity(.9),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
        if (widget.productModel.media.length > 1)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 170.0,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.productModel.media
                    .asMap()
                    .entries
                    .map(
                      (MapEntry<int, String> entry) => _bulletPoint(
                        entry,
                        _currentIndex,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
      ],
    );
  }
}
