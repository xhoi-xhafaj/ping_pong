import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/add_games/add_games.dart';

class PlayerTwoAddScoreButton extends StatelessWidget {
  const PlayerTwoAddScoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.0,
      child: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.black87),
        backgroundColor: Colors.white,
        onPressed: () {
          context.read<AddGameBloc>().add(AddPlayerTwoSetPoint());
        },
      ),
    );
  }
}
