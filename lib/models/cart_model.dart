import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final VarianteModel varianteModel;
  final OptionModel optionModel;

  const CartModel({
    required this.varianteModel,
    required this.optionModel,
  });

  bool get isEmpty => optionModel.isEmpty;

  factory CartModel.empty() => CartModel(
        varianteModel: VarianteModel.empty(),
        optionModel: OptionModel.empty(),
      );

  @override
  List<Object> get props => [
        varianteModel,
        optionModel,
      ];
}
