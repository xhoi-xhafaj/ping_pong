import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ping_pong/app/app.dart';
import 'package:ping_pong/username_check/username_check.dart';
import '../../app/app.dart';

class UsernameCheckScreen extends StatelessWidget {
  const UsernameCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => UsernameCubit(
          context.read<FirestoreRepository>(),
          context.read<AuthenticationRepository>(),
        ),
        child: const UsernameCheck(),
      ),
    );
  }
}

class UsernameCheck extends StatelessWidget {
  const UsernameCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsernameCubit, UsernameState>(
      listenWhen: (previous, current) =>
          previous.usernameStatus != current.usernameStatus,
      listener: (context, state) {
        if (state.usernameStatus.isRegistered) {
          context.read<UsernameCubit>().usernameStored();
          GoRouter.of(context).go("/home");
        }
        if (state.usernameStatus.isInvalid) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Username not available'),
              ),
            );
        }
      },
      buildWhen: (previous, current) =>
          previous.usernameStatus != current.usernameStatus,
      builder: (context, state) {
        if (state.usernameStatus.isUnknown) {
          context.read<UsernameCubit>().usernameCheckRegistration();
          return const Center(
              child: CircularProgressIndicator()
          );
        } else if (state.usernameStatus.isAvailable) {
          context.read<UsernameCubit>().registerUsername();
          return const Center(
              child: CircularProgressIndicator()
          );
        } else if (state.usernameStatus.isUnregistered || state.usernameStatus.isInvalid){
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const UsernameInput(),
                const SizedBox(height: 24,),
                _ConfirmUsernameButton(),
              ],
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator()
          );
        }
      },
    );
  }
}

class UsernameInput extends StatelessWidget {
  const UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<UsernameCubit, UsernameState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.07 * width),
          child: TextFormField(
            key: const Key('usernameForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<UsernameCubit>().usernameChanged(username),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0)),
              labelText: 'username',
              hintText: 'Enter your username',
              suffixIcon: state.username.valid
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : null,
              errorText:
                  state.username.invalid ? 'at least 4 characters' : null,
            ),
          ),
        );
      },
    );
  }
}


class _ConfirmUsernameButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF40916c);
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<UsernameCubit, UsernameState>(
      buildWhen: (previous, current) => previous.validationStatus != current.validationStatus,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('usernameForm_confirm_raisedButton'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            primary: color,
            minimumSize: Size(0.8*width, 45),
          ),
          onPressed: state.username.valid
              ? () => context.read<UsernameCubit>().usernameAvailable(state.username.value)
              : null,
          child: const Text(
            'CONFIRM',
            textScaleFactor: 1.3,
          ),
        );
      },
    );
  }
}
