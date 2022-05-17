import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/constants.dart';

import '../add_games.dart';

class SaveGameButton extends StatelessWidget {
  const SaveGameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: BlocBuilder<AddGameBloc, AddGameState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(0.45 * width, 40),
                  primary: choosePlayersContainerBackgroundColor),
              onPressed: () {
                context.read<AddGameBloc>().add(SaveGame());
              },
              child: Text(
                saveGameButtonSet,
                style: GoogleFonts.comfortaa(fontSize: 28, color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}
