import 'package:com_noopeshop_app/components/product_customizer/product_customizer/product_customizer_bloc.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:com_noopeshop_app/widgets/variante_selector_widget.dart';
import 'package:com_noopeshop_app/widgets/list_size_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCustomizerComponent extends StatelessWidget {
  final ProductModel productModel;

  const ProductCustomizerComponent({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCustomizerBloc>(
      create: (context) => ProductCustomizerBloc()
        ..add(OnChangeProductCustomizerEvent(
          varianteModel: productModel.variantes.first,
        )),
      child: BlocBuilder<ProductCustomizerBloc, ProductCustomizerState>(
        builder: (context, state) {
          VarianteModel currentVarianteModel =
              state is ProductCustomizerInitialState
                  ? productModel.variantes.first
                  : (state as ProductCustomizerLoadedState).varianteModel;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: Text(
                  "Color",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: VarianteSelectorWidget(
                  variantes: productModel.variantes,
                  selectedVariante: currentVarianteModel,
                  onSelected: (varianteModel) {
                    context.read<ProductCustomizerBloc>().add(
                          OnChangeProductCustomizerEvent(
                            varianteModel: varianteModel,
                          ),
                        );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: Text(
                  "Size",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 36.0,
                ),
                child: ListSizeSelectorWidget(
                  variantes: currentVarianteModel.options
                      .where((option) => option.value)
                      .map((option) => {
                            "size": option.key,
                          })
                      .toList(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
