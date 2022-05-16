

import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/add_games/screen/choose_players_body.dart';
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
              if (state.gameStatus.isCanceled) {
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
                /*return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          UserNamePlayerOne(),
                          Center(
                            child: Text(
                              'VS',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          UserNamePlayerTwo(),
                        ],
                      ),
                      const AddSetWidget(),
                    ],
                  ),
                );*/
              }
              else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}


class AddSetWidget extends StatelessWidget {
  const AddSetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextOfSet(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30.0,),
                  child: const PlayerOneSetPoint(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30.0,),
                  child: const PlayerTwoSetPoint(),
                )
              ],
            ),
            const AddSetButton(),
          ],
        ),
      ),
    );
  }
}

class PlayerOneSetPoint extends StatelessWidget {
  const PlayerOneSetPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const PlayerOneText(),
          Row(
            children: [
              const PlayerOneScoreSet(),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    PlayerOneAddScoreButton(),
                    PlayerOneSubtractScoreButton()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PlayerTwoSetPoint extends StatelessWidget {
  const PlayerTwoSetPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const PlayerTwoText(),
          Row(
            children: [
              const PlayerTwoScoreSet(),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    PlayerTwoAddScoreButton(),
                    PlayerTwoSubtractScoreButton()
                  ],
                ),
              )
            ],
          ),
        ],
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

