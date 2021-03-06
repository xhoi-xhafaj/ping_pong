import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/add_games/add_games.dart';

class TextOfSet extends StatelessWidget {
  const TextOfSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      buildWhen: (previous, current) => previous.currentSet.set != current.currentSet.set,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            "Set " + state.currentSet.set.toString(),
            style: GoogleFonts.comfortaa(fontSize: 20.0),
          ),
        );
      },
    );
  }
}
