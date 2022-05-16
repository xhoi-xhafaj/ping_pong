import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/add_games/add_games.dart';

class PlayerTwoText extends StatelessWidget {

  const PlayerTwoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      buildWhen: (previous, current) => previous.playerTwo != current.playerTwo,
      builder: (context, state) {
        return Text(
          state.playerTwo,
          style: GoogleFonts.comfortaa(
            fontSize: 24,
          ),
        );
      },
    );
  }
}