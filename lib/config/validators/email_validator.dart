import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum EmailInputError { empty, invalid }

class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');

  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty == true) {
      return EmailInputError.empty;
    }

    if (!isEmail(value)) {
      return EmailInputError.invalid;
    }

    return null;
  }
}
