import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firestore_repository/firestore_repository.dart';

import '../add_games.dart';

class ChooseTypeOfGame extends StatelessWidget {
  const ChooseTypeOfGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      buildWhen: (previous, current) =>
          previous.gameTypeBestOf != current.gameTypeBestOf,
      builder: (context, state) {
        var list = <String>[];
        for (var gameType in GameType.values) {
          list.add(gameType.name);
        }
        return DropdownButton<String>(
          value: state.gameTypeBestOf.name,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newGameType) {
            if (newGameType != null) {
              context.read<AddGameBloc>().add(ChangeTypeOfGame(newGameType));
            }
          },
        );
      },
    );
  }
}
