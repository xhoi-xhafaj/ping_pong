import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/constants.dart';

class PlayerTwoSubtractScoreButton extends StatelessWidget {
  const PlayerTwoSubtractScoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.0,
      child: FloatingActionButton(
        child: const Icon(Icons.remove, color: Colors.black87),
        backgroundColor: removePointButtonColor,
        onPressed: () {
          context.read<AddGameBloc>().add(RemovePlayerTwoSetPoint());
        },
        elevation: 0,
      ),
    );
  }
}
