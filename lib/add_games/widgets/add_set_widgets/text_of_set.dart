import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/add_games/add_games.dart';

class TextOfSet extends StatelessWidget {
  const TextOfSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      buildWhen: (previous, current) => previous.currentSet.set != current.currentSet.set,
      builder: (context, state) {
        return Text(
          "Set " + state.currentSet.set.toString(),
          style: const TextStyle(fontSize: 20.0),
        );
      },
    );
  }
}
