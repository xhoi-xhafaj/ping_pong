import 'package:formz/formz.dart';

/// Validation error for password
enum PasswordValidatorError {
  /// validation error
  invalid
}

/// Form input for a password input
class Password extends FormzInput<String, PasswordValidatorError> {

  const Password.pure() : super.pure('');

  /// modified password input
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  PasswordValidatorError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidatorError.invalid;
  }

}
