import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_games.dart';

class AddSetButton extends StatelessWidget {

  const AddSetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AddGameBloc, AddGameState>(
      builder: (context, state) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              minimumSize: Size(0.5 * width, 35),
            ),
            onPressed: state.currentSet.addButtonEnabled
                ? () {context.read<AddGameBloc>(); }
                : null,
            child: const Text(
              'ADD SET',
              style: TextStyle(fontSize: 28),
            ));
      },
    );
  }
}