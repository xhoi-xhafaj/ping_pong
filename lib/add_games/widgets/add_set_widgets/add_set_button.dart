import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/constants.dart';

import '../../add_games.dart';

class AddSetButton extends StatelessWidget {

  const AddSetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: BlocBuilder<AddGameBloc, AddGameState>(
          builder: (context, state) {
            return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(0.4 * width, 35),
                  primary: choosePlayersContainerBackgroundColor
                ),
                onPressed: state.currentSet.addButtonEnabled
                    ? () { context.read<AddGameBloc>().add(AddSet()); }
                    : null,
                child: Text(
                  addSetButtonText,
                  style: GoogleFonts.comfortaa(fontSize: 28, color: Colors.black),
                ));
          },
        ),
      ),
    );
  }
}