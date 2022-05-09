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
    var registered = await _firestoreRepository.checkUsersUsername(_authenticationRepository.currentUser.id);
    emit(
        registered
            ? state.copyWith(usernameStatus: UsernameStatus.registered)
            : state.copyWith(usernameStatus: UsernameStatus.unregistered)
    );
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