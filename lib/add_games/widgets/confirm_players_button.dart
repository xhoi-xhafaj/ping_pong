
import '';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_games.dart';

class ConfirmPlayersButton extends StatelessWidget {

  const ConfirmPlayersButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AddGameBloc, AddGameState>(
      builder: (context, state) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: Size(0.75 * width, 45),
            ),
            onPressed: () {
              context
                  .read<AddGameBloc>()
                  .add(InitializeNewGame());
            },
            child: const Text(
              'START GAME',
              style: TextStyle(fontSize: 30),
            ));
      },
    );
  }

}