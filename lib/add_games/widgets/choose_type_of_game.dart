import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../add_games.dart';

class ChooseTypeOfGame extends StatelessWidget {
  const ChooseTypeOfGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <String>[];
    for (var gameType in GameType.values) {
      list.add(gameType.name);
    }
    String selectedChip = list[0];
    List<Widget> choices = [];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<AddGameBloc, AddGameState>(
        buildWhen: (previous, current) =>
        previous.gameTypeBestOf != current.gameTypeBestOf,
        builder: (context, state) {
          choices.clear();
          list.forEach((element) {
            choices.add(
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: ChoiceChip(
                  selected: selectedChip == element,
                  label: Text(
                    "best of "+element,
                    style: GoogleFonts.comfortaa(
                      fontSize: 16,
                    ),
                  ),
                  onSelected: (selected) {
                    selectedChip = element;
                    context.read<AddGameBloc>().add(ChangeTypeOfGame(selectedChip));
                  },
                  backgroundColor: choosePlayersCardBackground,
                  selectedColor: choosePlayersContainerBackgroundColor,
                ),
              ),
            );
          });
          return Row(children: choices,);
        },
      ),
    );
  }
}
