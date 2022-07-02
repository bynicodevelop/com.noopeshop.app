import 'package:formz/formz.dart';

enum CityInputError { empty }

class CityInput extends FormzInput<String, CityInputError> {
  const CityInput.pure() : super.pure('');

  const CityInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CityInputError? validator(String value) {
    return value.isNotEmpty == true ? null : CityInputError.empty;
  }
}
