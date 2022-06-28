import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum ExpiryInputError { empty, invalide }

class ExpiryInput extends FormzInput<String, ExpiryInputError> {
  const ExpiryInput.pure() : super.pure('');

  const ExpiryInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ExpiryInputError? validator(String value) {
    if (value.isEmpty) {
      return ExpiryInputError.empty;
    }

    if (!isNumeric(value)) {
      return ExpiryInputError.invalide;
    }

    if (value.length != 4) {
      return ExpiryInputError.invalide;
    }

    return null;
  }
}
