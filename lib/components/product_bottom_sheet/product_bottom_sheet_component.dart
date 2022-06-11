import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/screens/description_product_screen.dart';
import 'package:flutter/material.dart';

class ProductBottomSheetComponent extends StatelessWidget {
  final ProductModel productModel;

  const ProductBottomSheetComponent({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescriptionProductScreen(
              productModel: productModel,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        height: 180.0,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 32.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              24.0,
            ),
            topRight: Radius.circular(
              24.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: Text(
                productModel.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Text(
              productModel.description,
              style: Theme.of(context).textTheme.bodyText1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
