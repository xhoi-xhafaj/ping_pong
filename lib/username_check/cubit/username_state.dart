part of 'username_cubit.dart';

enum UsernameStatus {
  unknown,
  registered,
  unregistered,
  available,
  invalid
}

class UsernameState extends Equatable {

 final Username username;
 final UsernameStatus usernameStatus;
 final FormzStatus validationStatus;
 final String? errorMessage;

  const UsernameState({
    this.username = const Username.pure(),
    this.usernameStatus = UsernameStatus.unknown,
    this.validationStatus = FormzStatus.pure,
    this.errorMessage,
  });

  UsernameState copyWith({
    Username? username,
    UsernameStatus? usernameStatus,
    FormzStatus? validationStatus,
    String? errorMessage
  }) {
    return UsernameState(
      username: username ?? this.username,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      validationStatus: validationStatus ?? this.validationStatus,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [username, usernameStatus, validationStatus, errorMessage];

}

extension UserStatusX on UsernameStatus {

  bool get isUnknown => this == UsernameStatus.unknown;

  bool get isRegistered => this == UsernameStatus.registered;

  bool get isUnregistered => this == UsernameStatus.unregistered;

  bool get isAvailable => this == UsernameStatus.available;

  bool get isInvalid => this == UsernameStatus.invalid;

}