import 'package:equatable/equatable.dart';

enum GameType {
  three,
  five,
  seven,
}

enum GameStatus {
  initialized,
  started,
  finished,
  canceled,
}

class GameInfo extends Equatable {
  final String playerOne;
  final String playerTwo;
  final String winner;
  final GameType gameTypeBestOf;
  final GameStatus gameStatus;
  final int winSetPlayerOne;
  final int winSetPlayerTwo;

  GameInfo({
    required this.playerOne,
    required this.playerTwo,
    required this.winner,
    required this.gameTypeBestOf,
    required this.gameStatus,
    required this.winSetPlayerOne,
    required this.winSetPlayerTwo,
  });

  factory GameInfo.fromSnapshot(Map<String, dynamic> doc) {
    GameInfo gameInfo = GameInfo(
      playerOne: doc["player_one"] ?? "",
      playerTwo: doc["player_two"] ?? "",
      winner: doc["winner"] ?? "",
      gameTypeBestOf: GameType.values.byName(doc["game_type"]),
      gameStatus: GameStatus.values.byName(doc["game_status"]),
      winSetPlayerOne: doc["win_set_player_one"] ?? 0,
      winSetPlayerTwo: doc["win_set_player_two"] ?? 0,
    );
    return gameInfo;
  }

  @override
  List<Object?> get props => [
        playerOne,
        playerTwo,
        winner,
        gameStatus,
        gameTypeBestOf,
        winSetPlayerOne,
        winSetPlayerTwo
      ];
}
