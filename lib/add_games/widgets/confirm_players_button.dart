import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/constants.dart';
import '../add_games.dart';

class ConfirmPlayersButton extends StatelessWidget {
  const ConfirmPlayersButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool startGame = false;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 0.2 * size.width, vertical: 0.06 * size.height),
      child: BlocBuilder<AddGameBloc, AddGameState>(
        builder: (context, state) {
          startGame = state.playerOne.isNotEmpty &&
              state.playerTwo.isNotEmpty &&
              state.gameTypeBestOf.name.isNotEmpty;
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(0.75 * size.width, 45),
                primary: choosePlayersContainerBackgroundColor,
              ),
              onPressed: startGame
                  ? () {
                      context.read<AddGameBloc>().add(InitializeNewGame());
                    }
                  : null,
              child: Text(
                'Start Game',
                style: GoogleFonts.comfortaa(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ));
        },
      ),
    );
  }
}
