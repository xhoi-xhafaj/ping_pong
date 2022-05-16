import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/constants.dart';

class PlayerOneScoreSet extends StatelessWidget {
  const PlayerOneScoreSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: BlocBuilder<AddGameBloc, AddGameState>(
        buildWhen: (previous, current) => previous.currentSet.playerOneScore != current.currentSet.playerOneScore,
        builder: (context, state) {
          return Text(
            state.currentSet.playerOneScore.toString(),
            style: GoogleFonts.comfortaa(fontSize: 30.0),
          );
        },
      ),
    );
  }
}