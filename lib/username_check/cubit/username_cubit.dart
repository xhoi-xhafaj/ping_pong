import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'username_state.dart';

class UsernameCubit extends Cubit<UsernameState> {

  final FirestoreRepository _firestoreRepository;
  final AuthenticationRepository _authenticationRepository;

  UsernameCubit(this._firestoreRepository, this._authenticationRepository) : super(const UsernameState());

  void usernameCheckRegistration() async {
    bool registered = await _firestoreRepository.checkUsersUsername(_authenticationRepository.currentUser.id);
    emit(
        registered
            ? state.copyWith(usernameStatus: UsernameStatus.registered)
            : state.copyWith(usernameStatus: UsernameStatus.unregistered)
    );
  }

  void usernameStored() {
    _firestoreRepository.storeUsername(_authenticationRepository.currentUser.id);
  }

  Future<void> usernameAvailable(String username) async {
    bool available = await _firestoreRepository.checkUsernameAvailable(username);
    emit(
      available
          ? state.copyWith(usernameStatus: UsernameStatus.available, username: Username.dirty(username))
          : state.copyWith(usernameStatus: UsernameStatus.invalid)
    );
  }

  void registerUsername() async {
    final user = _authenticationRepository.currentUser;
    try {
       _firestoreRepository.registerUsername(
        user.id, state.username.value, user.email!
      );
      emit(
        state.copyWith(usernameStatus: UsernameStatus.unknown)
      );
    } catch (_) {
      emit(
        state.copyWith(usernameStatus: UsernameStatus.invalid)
      );
    }
  }

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        validationStatus: Formz.validate([username]),
      ),
    );
  }
}