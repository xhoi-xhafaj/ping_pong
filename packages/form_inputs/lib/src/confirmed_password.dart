import 'package:formz/formz.dart';

/// Validation error for Confirmed Password
enum ConfirmedPasswordValidationError {
  /// invalid error
  invalid
}

/// form input for a confirmed password input
class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {

  /// modified confirmed password input
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// pure confirmed password input
  const ConfirmedPassword.pure({this.password = ''})
      : super.pure('');

  /// password
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String? value) {
    return (password == value && password.length >= 8)
        ? null
        : ConfirmedPasswordValidationError.invalid;
  }

}
