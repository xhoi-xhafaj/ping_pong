import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/add_games/widgets/add_set_widgets/playing_text.dart';
import 'package:ping_pong/add_games/widgets/save_game_button.dart';
import '../../constants.dart';
import 'game_started_body.dart';

class FinishGameBody extends StatelessWidget {
  const FinishGameBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.3,
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
                height: size.height * 0.3 - 95,
                decoration: const BoxDecoration(
                  color: choosePlayersContainerBackgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: gameStartedDefaultPadding),
                  height: 190,
                  decoration: BoxDecoration(
                    color: choosePlayersCardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const PlayersScoreWidget(),
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
                GameStatsText(),
                GameStatsWidget(),
                SaveGameButton(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class GameStatsWidget extends StatelessWidget {
  const GameStatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: choosePlayersCardBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [GameStatsPlayersName(), GameStatsListOfResults()],
      ),
    );
  }
}

class GameStatsPlayersName extends StatelessWidget {
  const GameStatsPlayersName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: const PlayerOneText(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: const PlayerTwoText(),
          )
        ],
      ),
    );
  }
}

class GameStatsListOfResults extends StatelessWidget {
  const GameStatsListOfResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> sets = [];
    return Expanded(
      child: BlocBuilder<AddGameBloc, AddGameState>(
        buildWhen: (previous, current) =>
            previous.savedSets != previous.savedSets,
        builder: (context, state) {
          state.savedSets.forEach((element) {
            sets.add(Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: SetStats(
                  nameOfSet: "Set " + element.set.toString(),
                  playerOneSetScore: element.playerOneScore,
                  playerTwoSetScore: element.playerTwoScore,
                ),
              ),
            ));
          });
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: sets.length,
            itemBuilder: ((context, index) {
              return sets[index];
            }),
          );
        },
      ),
    );
  }
}

class SetStats extends StatelessWidget {
  const SetStats(
      {Key? key,
      required this.nameOfSet,
      required this.playerOneSetScore,
      required this.playerTwoSetScore})
      : super(key: key);

  final String nameOfSet;
  final int playerOneSetScore;
  final int playerTwoSetScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            nameOfSet,
            style: GoogleFonts.comfortaa(fontSize: 24),
          ),
        ),
        Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: playerOneSetScore > playerTwoSetScore
                ? addPointButtonColor
                : removePointButtonColor,
          ),
          child: Center(
            child: Text(
              playerOneSetScore.toString(),
              style: GoogleFonts.comfortaa(fontSize: 24),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: playerOneSetScore < playerTwoSetScore
                ? addPointButtonColor
                : removePointButtonColor,
          ),
          child: Center(
            child: Text(
              playerTwoSetScore.toString(),
              style: GoogleFonts.comfortaa(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
