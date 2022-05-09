import 'package:flutter/material.dart';
import 'package:ping_pong/add_games/add_games.dart';

class AddGamesScreen extends StatelessWidget {
  const AddGamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0,),
            Text('Choose the players',
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 20.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const UserNameAvatarCurrentPlayer(),
                const Center(
                  child: Text(
                    'VS',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const UserNameAvatarCurrentPlayer()
              ],
            ),
            const SizedBox(height: 20.0,),
            Text(
              """Let's play""",
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'best of',
                  style: TextStyle(fontSize: 35),
                ),
                SizedBox(width: 12,),
                Text(
                  '3',
                  style: TextStyle(fontSize: 35),
                )
              ],
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(0.8*width, 45),
                ),

                onPressed: () {

                },
                child: Text(
                  'START GAME',
                  style: TextStyle(fontSize: 30),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class UserNameAvatarCurrentPlayer extends StatelessWidget {
  const UserNameAvatarCurrentPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Avatar(),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Player',
          style: TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}
