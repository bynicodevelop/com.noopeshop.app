import 'package:com_noopeshop_app/components/options/options/options_bloc.dart';
import 'package:com_noopeshop_app/components/options/options_component.dart';
import 'package:com_noopeshop_app/components/variantes/variantes/variantes_bloc.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:com_noopeshop_app/services/cart_product/cart_product_bloc.dart';
import 'package:com_noopeshop_app/widgets/variante_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VarianteComponent extends StatelessWidget {
  final List<VarianteModel> variantes;

  const VarianteComponent({
    Key? key,
    required this.variantes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VarianteModel currentVariante = variantes.first;

    return BlocProvider<VariantesBloc>(
      create: (context) => VariantesBloc(
        varianteModel: currentVariante,
      )..add(OnSelectVarianteEvent(
          varianteModel: currentVariante,
        )),
      child: BlocProvider<OptionsBloc>(
        create: (context) => OptionsBloc(),
        child: BlocConsumer<VariantesBloc, VariantesState>(
          listener: (context, state) {
            currentVariante = (state as VariantesInitialState).varianteModel;

            context.read<OptionsBloc>().add(
                  OnChangeOptionsEvent(
                    option: currentVariante.options.first,
                  ),
                );

            context.read<CartProductBloc>().add(
                  OnUpdateCartProductEvent(
                    varianteModel: currentVariante,
                    optionModel: currentVariante.options.first,
                  ),
                );
          },
          builder: (context, state) {
            currentVariante = (state as VariantesInitialState).varianteModel;

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
                    variantes: variantes,
                    selectedVariante: currentVariante,
                    onSelected: (varianteModel) {
                      context.read<VariantesBloc>().add(
                            OnSelectVarianteEvent(
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
                    bottom: 16.0,
                  ),
                  child: OptionsComponent(
                    options: currentVariante.options,
                    onSelectOption: (optionModel) =>
                        context.read<CartProductBloc>().add(
                              OnUpdateCartProductEvent(
                                varianteModel: currentVariante,
                                optionModel: optionModel,
                              ),
                            ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
