import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_games.dart';

class ChoosePlayerOne extends StatelessWidget {

  const ChoosePlayerOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      buildWhen: (previous, current) => previous.playerOne != current.playerOne || previous.playerTwo != current.playerTwo,
      builder: (context, state) {
        var list = <String>[];
        list.addAll(state.players);
        if (state.playerTwo != "") {
          list.remove(state.playerTwo);
        }
        return DropdownButton<String>(
          value: state.playerOne ,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              context.read<AddGameBloc>().add(ChangePlayerOne(newValue));
            }
          },
        );
      },
    );
  }
}