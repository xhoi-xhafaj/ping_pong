import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ping_pong/home/home.dart';
import 'package:ping_pong/login/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ping_pong/sign_up/sign_up.dart';
import 'package:ping_pong/splash/splash.dart';
import 'package:ping_pong/app/app.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/username_check/screen/username_check_screen.dart';


class App extends StatelessWidget {

  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required FirestoreRepository firestoreRepository
  })  : _authenticationRepository = authenticationRepository,
        _firestoreRepository = firestoreRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final FirestoreRepository _firestoreRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: RepositoryProvider.value(
        value: _firestoreRepository,
        child: BlocProvider(
          create: (_) => AppBloc(
            authenticationRepository: _authenticationRepository,
            firestoreRepository: _firestoreRepository
          ),
          child: AppViewRoute(),
        ),
      ),
    );
  }
}

class AppViewRoute extends StatelessWidget {

  AppViewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _goRouter.routeInformationParser,
      routerDelegate: _goRouter.routerDelegate,
      theme: Theme.of(context),
    );
  }

  final GoRouter _goRouter = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
      ),
      GoRoute(path: '/addmatches',
        builder: (BuildContext context, GoRouterState state) => const AddGamesScreen(),
      ),
      GoRoute(path: '/usernamecheck',
        builder: (BuildContext context, GoRouterState state) => const UsernameCheckScreen(),
      )
    ],
  );

}