import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum PostalCodeInputError { empty, invalide }

class PostalCodeInput extends FormzInput<String, PostalCodeInputError> {
  const PostalCodeInput.pure() : super.pure('');

  const PostalCodeInput.dirty({String value = ''}) : super.dirty(value);

  @override
  PostalCodeInputError? validator(String value) {
    if (value.isEmpty) {
      return PostalCodeInputError.empty;
    }

    if (!isNumeric(value)) {
      return PostalCodeInputError.invalide;
    }

    if (value.length < 5) {
      return PostalCodeInputError.invalide;
    }

    return null;
  }
}
