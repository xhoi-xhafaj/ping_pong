part of 'app_bloc.dart';

class AppEvent extends Equatable {

  const AppEvent();

  @override
  List<Object?> get props => [];

}

class AppLogoutRequest extends AppEvent {}

class AppUserChanged extends AppEvent {

  final User user;

  @visibleForTesting
  const AppUserChanged(this.user);

  @override
  List<Object> get props => [user];

}

class CheckUserRegistered extends AppEvent{}
