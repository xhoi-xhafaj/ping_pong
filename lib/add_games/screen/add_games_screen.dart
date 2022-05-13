import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/add_games/widgets/add_set_widgets/add_set_button.dart';

class AddGamesScreen extends StatelessWidget {
  const AddGamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => AddGameBloc(
        firestoreRepository:
            RepositoryProvider.of<FirestoreRepository>(context),
      ),
      child: Scaffold(
        body: BlocConsumer<AddGameBloc, AddGameState>(
          listenWhen: (previous, current) =>
              previous.gameStatus != current.gameStatus,
          listener: (context, state) {},
          buildWhen: (previous, current) =>
              previous.gameStatus != current.gameStatus,
          builder: (context, state) {
            context.read<AddGameBloc>().add(GetListOfOpponents());
            if (state.gameStatus.isInitialized) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'Choose the players',
                      style: TextStyle(fontSize: 35),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        UserNameAvatarPlayerOne(),
                        Center(
                          child: Text(
                            'VS',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        UserNameAvatarPlayerTwo()
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      """Let's play""",
                      style: TextStyle(fontSize: 35),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'best of',
                          style: TextStyle(fontSize: 35),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        ChooseTypeOfGame(),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const ConfirmPlayersButton(),
                  ],
                ),
              );
            } else  if (state.gameStatus.isStarted) {
              return Padding(
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
              );
            }
            else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class UserNameAvatarPlayerOne extends StatelessWidget {
  const UserNameAvatarPlayerOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [Avatar(), ChoosePlayerOne()],
    );
  }
}

class UserNameAvatarPlayerTwo extends StatelessWidget {
  const UserNameAvatarPlayerTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Avatar(),
        ChoosePlayerTwo(),
      ],
    );
  }
}

class UserNamePlayerOne extends StatelessWidget {
  const UserNamePlayerOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Column(
     mainAxisSize: MainAxisSize.min,
     children: const [
       Avatar(),
       PlayerOneText(),
       PlayerOneScore(),
     ],
   );
  }
}

class UserNamePlayerTwo extends StatelessWidget {
  const UserNamePlayerTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Avatar(),
        PlayerTwoText(),
        PlayerTwoScore(),
      ],
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

