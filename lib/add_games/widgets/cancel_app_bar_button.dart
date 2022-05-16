import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_pong/add_games/add_games.dart';

class CancelAppBarButton extends StatelessWidget {
  const CancelAppBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGameBloc, AddGameState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 52,
          ),
          onPressed: () {
            context.read<AddGameBloc>().add(CancelGame());
          },
        );
      },
    );
  }
}
