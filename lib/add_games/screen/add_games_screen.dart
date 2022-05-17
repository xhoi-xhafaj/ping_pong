

import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/add_games/screen/choose_players_body.dart';
import 'package:ping_pong/add_games/screen/finish_game_body.dart';
import 'package:ping_pong/constants.dart';

class AddGamesScreen extends StatelessWidget {
  const AddGamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: choosePlayersContainerBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (BuildContext context) => AddGameBloc(
          firestoreRepository:
              RepositoryProvider.of<FirestoreRepository>(context),
        ),
        child: Scaffold(
          appBar: buildAppBar(),
          body: BlocConsumer<AddGameBloc, AddGameState>(
            listenWhen: (previous, current) =>
                previous.gameStatus != current.gameStatus,
            listener: (context, state) {
              if (state.gameStatus.isCanceled || state.gameStatus.isSaved) {
                GoRouter.of(context).go('/home');
              }
            },
            buildWhen: (previous, current) =>
                previous.gameStatus != current.gameStatus,
            builder: (context, state) {
              context.read<AddGameBloc>().add(GetListOfOpponents());
              if (state.gameStatus.isInitialized) {
                return const ChoosePlayersBody();
              } else  if (state.gameStatus.isStarted) {
                return const GameStartedBody();
              } else if (state.gameStatus.isFinished){
                return const FinishGameBody();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}


AppBar buildAppBar() {
  return AppBar(
    backgroundColor: choosePlayersContainerBackgroundColor,
    elevation: 0,
    leading: const CancelAppBarButton(),
  );
}

