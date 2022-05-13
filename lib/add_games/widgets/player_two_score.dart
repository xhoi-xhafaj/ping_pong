import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/add_games/add_games.dart';

class PlayerTwoScore extends StatelessWidget {

  const PlayerTwoScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      buildWhen: (previous, current) => previous.winSetPlayerTwo != current.winSetPlayerTwo,
      builder: (context, state) {
        return Text(
          state.winSetPlayerTwo.toString(),
          style: const TextStyle(
            fontSize: 35,
          ),
        );
      },
    );
  }
}