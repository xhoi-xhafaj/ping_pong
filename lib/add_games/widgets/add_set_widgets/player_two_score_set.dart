import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/add_games/add_games.dart';

class PlayerTwoScoreSet extends StatelessWidget {
  const PlayerTwoScoreSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: BlocBuilder<AddGameBloc, AddGameState>(
        buildWhen: (previous, current) => previous.currentSet.playerTwoScore != current.currentSet.playerTwoScore,
        builder: (context, state) {
          return Text(
            state.currentSet.playerTwoScore.toString(),
            style: GoogleFonts.comfortaa(fontSize: 30.0),
          );
        },
      ),
    );
  }
}