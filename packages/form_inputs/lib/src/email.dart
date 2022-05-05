import 'package:formz/formz.dart';

/// Validation error for Email Validation
enum EmailValidatorError {
  /// validation error
  invalid
}

/// Form input for an email input
class Email extends FormzInput<String, EmailValidatorError> {

  const Email.pure() : super.pure('');

  /// modified email input
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidatorError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidatorError.invalid;
  }

}
