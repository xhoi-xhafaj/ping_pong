import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/add_games/widgets/add_set_widgets/playing_text.dart';
import 'package:ping_pong/constants.dart';

class GameStartedBody extends StatelessWidget {
  const GameStartedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.28,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: addSetBackgroundColor,
                ),
              ),
              Container(
                height:  size.height * 0.28 - 95,
                decoration: const BoxDecoration(
                  color: choosePlayersContainerBackgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: gameStartedDefaultPadding),
                  height: 190,
                  decoration: BoxDecoration(
                    color: choosePlayersCardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: PlayersScoreWidget(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: addSetBackgroundColor,
            ),
            child: Column(
              children: const [
                PlayingText(),
                AddSetPoint(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PlayersScoreWidget extends StatelessWidget {
  const PlayersScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const GameTypeText(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              UserNamePlayerOne(),
              ScoreStatsWidget(),
              UserNamePlayerTwo(),
            ],
          ),
        ),
      ],
    );
  }
}

class UserNamePlayerOne extends StatelessWidget {
  const UserNamePlayerOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Avatar(),
        PlayerOneText(),
      ],
    );
  }
}

class UserNamePlayerTwo extends StatelessWidget {
  const UserNamePlayerTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Avatar(),
        PlayerTwoText(),
      ],
    );
  }
}

class PlayersScoreText extends StatelessWidget {
  const PlayersScoreText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const PlayerOneScore(),
        Text(
          " : ",
          style: GoogleFonts.comfortaa(
            fontSize: 30,
          ),
        ),
        const PlayerTwoScore()
      ],
    );
  }

}

class ScoreStatsWidget extends StatelessWidget {
  const ScoreStatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: const Center(
        child: PlayersScoreText(),
      ),
    );
  }
}

class AddSetPoint extends StatelessWidget {
  const AddSetPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      margin: const EdgeInsets.symmetric(horizontal: 30,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: choosePlayersCardBackground,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextOfSet(),
          PlayerOneNameAndScore(),
        ],
      ),
    );
  }
}

class PlayerOneNameAndScore extends StatelessWidget {
  const PlayerOneNameAndScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
   return Container(
     margin: const EdgeInsets.all(10),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         const PlayerOneText(),
         SizedBox(
           width: 0.3 * size.width,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: const [
               PlayerOneSubtractScoreButton(),
               PlayerOneScoreSet(),
               PlayerOneAddScoreButton(),
             ],
           ),
         ),
       ],
     ),
   );
  }
}

class PlayerTwoNameAndScore extends StatelessWidget {
  const PlayerTwoNameAndScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const PlayerTwoText(),
          SizedBox(
            width: 0.3 * size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                PlayerOneSubtractScoreButton(),
                PlayerOneScoreSet(),
                PlayerOneAddScoreButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
