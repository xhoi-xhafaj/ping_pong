import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

class SetScore extends Equatable {
  final String set;
  final String playerOne;
  final String playerTwo;
  final int setScorePlayerOne;
  final int setScorePlayerTwo;

  SetScore({
      required this.set,
      required this.playerOne,
      required this.playerTwo,
      required this.setScorePlayerOne,
      required this.setScorePlayerTwo});

  @override
  List<Object?> get props =>
      [set, playerOne, playerTwo, setScorePlayerOne, setScorePlayerTwo];
}
