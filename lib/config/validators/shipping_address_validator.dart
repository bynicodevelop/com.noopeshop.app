import 'package:formz/formz.dart';

enum ShippingAddressInputError { empty }

class ShippingAddressInput
    extends FormzInput<String, ShippingAddressInputError> {
  const ShippingAddressInput.pure() : super.pure('');

  const ShippingAddressInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ShippingAddressInputError? validator(String value) {
    return value.isNotEmpty == true ? null : ShippingAddressInputError.empty;
  }
}
