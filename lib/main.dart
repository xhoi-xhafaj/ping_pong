import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/login/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ping_pong/splash/splash.dart';
import 'package:ping_pong/app/app.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final authenticationRepository = AuthenticationRepository();
    final firestoreRepository = FirestoreRepository();
    await authenticationRepository.user.first;
    runApp(
        App(
          authenticationRepository: authenticationRepository,
          firestoreRepository: firestoreRepository,
        )
    );
  });
}
