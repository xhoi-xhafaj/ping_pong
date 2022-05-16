import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ping_pong/constants.dart';

class PlayingText extends StatelessWidget{
  const PlayingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        playingText,
        style: GoogleFonts.comfortaa(
          fontSize: 25,
        ),
      ),
    );
  }
}