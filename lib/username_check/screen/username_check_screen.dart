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
          GoRouter.of(context).go("/home");
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
        } else if (state.usernameStatus.isUnregistered) {
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UsernameInput(),
              ],
            ),
          );
        } else {
          return Container();
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
