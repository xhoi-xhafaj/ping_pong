part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated
}

enum UserStatus {
  unknown,
  registered,
  unregistered
}

class AppState extends Equatable {

  final AppStatus status;
  final User user;
  final UserStatus userStatus;

  const AppState._({
    required this.status,
    this.user = User.empty,
    this.userStatus = UserStatus.unknown
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated()
      : this._(status: AppStatus.unauthenticated);

  const AppState.registered(UserStatus userStatus, User user)
      : this._(status: AppStatus.authenticated, userStatus: userStatus,user: user);

  @override
  List<Object?> get props => [status, user, userStatus];

}

extension UserStatusX on UserStatus {

  bool get isUnknown => this == UserStatus.unknown;

  bool get isRegistered => this == UserStatus.registered;

  bool get isUnregistered => this == UserStatus.unregistered;

}
