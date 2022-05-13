import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/add_games/add_games.dart';

class PlayerOneScoreSet extends StatelessWidget {
  const PlayerOneScoreSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      buildWhen: (previous, current) => previous.currentSet.playerOneScore != current.currentSet.playerOneScore,
      builder: (context, state) {
        return Text(
          state.currentSet.playerOneScore.toString(),
          style: const TextStyle(fontSize: 45.0),
        );
      },
    );
  }
}