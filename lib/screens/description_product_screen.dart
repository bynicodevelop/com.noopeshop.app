import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:flutter/material.dart';

class DescriptionProductScreen extends StatelessWidget {
  final ProductModel productModel;

  const DescriptionProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ),
              child: Text(
                productModel.title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: kBackgroundColor,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  shadows: [],
                ),
              ),
            ),
            Text(
              productModel.description,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: kBackgroundColor,
                    fontSize: 14.0,
                    letterSpacing: .9,
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
