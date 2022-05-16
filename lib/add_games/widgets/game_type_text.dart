import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/add_games/add_games.dart';

class GameTypeText extends StatelessWidget {
  const GameTypeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      buildWhen: (previous, current) => previous.gameTypeBestOf != current.gameTypeBestOf,
      builder: (context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: Text(
            "best of "+state.gameTypeBestOf.name,
            style: GoogleFonts.comfortaa(
              fontSize: 15,
            ),
          ),
        );
      },
    );
  }

}