import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:ping_pong/constants.dart';

class ChoosePlayersBody extends StatelessWidget {

  const ChoosePlayersBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.42,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: choosePlayersBackgroundColor,
                ),
              ),
              Container(
                height:  size.height * 0.42 - 95,
                decoration: const BoxDecoration(
                  color: choosePlayersContainerBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36)
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: choosePlayersDefaultPadding),
                  height: 190,
                  decoration: BoxDecoration(
                    color: choosePlayersCardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const ChoosePlayersWidget(),
                ),
              ),
              ChoosePlayersText(topPositionSize: size.height * 0.06),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: choosePlayersBackgroundColor,
            ),
            child: Column(
              children: const [
                LetsPlayText(),
                ChooseTypeOfGame(),
                ConfirmPlayersButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChoosePlayersText extends StatelessWidget {
  const ChoosePlayersText({Key? key, required this.topPositionSize}) : super(key: key);

  final double topPositionSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPositionSize,
      right: 0,
      left: 0,
      child: Center(
        child: Text(
          choosePlayersText,
          style: GoogleFonts.comfortaa(
            fontSize: choosePlayersTextSize,
          ),
        ),
      ),
    );
  }

}

class ChoosePlayersWidget extends StatelessWidget {
  const ChoosePlayersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.34,
            child: const UserNameAvatarPlayerOne(),
          ),
          Center(
            child: Text(
              'VS',
              style: GoogleFonts.comfortaa(fontSize: 30),
            ),
          ),
          SizedBox(
            width: size.width * 0.34,
            child: const UserNameAvatarPlayerTwo(),
          ),
        ],
      ),
    );
  }
}

class UserNameAvatarPlayerOne extends StatelessWidget {
  const UserNameAvatarPlayerOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Avatar(),
        ChoosePlayerOne()
      ],
    );
  }
}

class UserNameAvatarPlayerTwo extends StatelessWidget {
  const UserNameAvatarPlayerTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Avatar(),
        ChoosePlayerTwo(),
      ],
    );
  }
}

class LetsPlayText extends StatelessWidget {
  const LetsPlayText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Center(
        child: Text(
          letsPlay,
          style: GoogleFonts.comfortaa(
            fontSize: letsPlayTextSize,
          ),
        ),
      ),
    );
  }
}
