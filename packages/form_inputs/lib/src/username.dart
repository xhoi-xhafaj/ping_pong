import 'package:formz/formz.dart';

/// Validation error for username
enum UsernameValidatorError {
  /// validator error
  invalid
}

/// Form input for username input
class Username extends FormzInput<String, UsernameValidatorError> {

  const Username.pure() : super.pure('');

  /// modified password input
  const Username.dirty([String value = '']) : super.dirty(value);

  static final _usernameRegExp = RegExp(
    '.{4,}',
  );

  @override
  UsernameValidatorError? validator(String? value) {
    return _usernameRegExp.hasMatch(value ?? '')
        ? null
        : UsernameValidatorError.invalid;
  }
}
