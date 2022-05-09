import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required FirestoreRepository firestoreRepository
  }) : _authenticationRepository = authenticationRepository,
        _firestoreRepository = firestoreRepository,
  super(
        authenticationRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequest>(_onLogoutRequested);
    on<CheckUserRegistered>(_onUsernameCheck);
    _userSubscription = _authenticationRepository.user.listen(
            (user) => add(AppUserChanged(user)));
  }

  final AuthenticationRepository _authenticationRepository;
  final FirestoreRepository _firestoreRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emitter) {
    emitter(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequest event, Emitter<AppState> emitter) {
    unawaited(_authenticationRepository.logOut());
  }

  void _onUsernameCheck(CheckUserRegistered event, Emitter<AppState> emitter) async {
    var registered = await _firestoreRepository.checkUsersUsername(state.user.id);
    emitter(
        registered
            ? AppState.registered(UserStatus.registered, state.user)
            : AppState.registered(UserStatus.unregistered, state.user)
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
