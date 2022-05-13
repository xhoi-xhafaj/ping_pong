part of 'add_game_bloc.dart';

class AddGameState extends Equatable {
  final String playerOne;
  final String playerTwo;
  final String winner;
  final GameType gameTypeBestOf;
  final GameStatus gameStatus;
  final int winSetPlayerOne;
  final int winSetPlayerTwo;
  final List<String> players;
  final String documentId;
  final Set currentSet;

  const AddGameState({
    this.playerOne = '',
    this.playerTwo = '',
    this.winner = '',
    this.gameStatus = GameStatus.initialized,
    this.gameTypeBestOf = GameType.three,
    this.winSetPlayerOne = 0,
    this.winSetPlayerTwo = 0,
    this.players = const <String>[],
    this.documentId = '',
    this.currentSet = const Set(),
  });

  AddGameState copyWith({
    String? playerOne,
    String? playerTwo,
    String? winner,
    GameType? gameTypeBestOf,
    GameStatus? gameStatus,
    int? winSetPlayerOne,
    int? winSetPlayerTwo,
    List<String>? players,
    String? documentId,
    Set? currentSet,
  }) {
    return AddGameState(
      playerOne: playerOne ?? this.playerOne,
      playerTwo: playerTwo ?? this.playerTwo,
      winner: winner ?? this.winner,
      gameTypeBestOf: gameTypeBestOf ?? this.gameTypeBestOf,
      winSetPlayerOne: winSetPlayerOne ?? this.winSetPlayerOne,
      winSetPlayerTwo: winSetPlayerTwo ?? this.winSetPlayerTwo,
      gameStatus: gameStatus ?? this.gameStatus,
      players: players ?? this.players,
      documentId: documentId ?? this.documentId,
      currentSet: currentSet ?? this.currentSet,
    );
  }

  @override
  List<Object?> get props => [
        playerOne,
        playerTwo,
        winner,
        gameStatus,
        gameTypeBestOf,
        winSetPlayerOne,
        winSetPlayerTwo,
        players,
        documentId,
        currentSet,
      ];
}

class Set extends Equatable {
  final int set;
  final int playerOneScore;
  final int playerTwoScore;
  final bool addButtonEnabled;

  const Set({
    this.set = 0,
    this.playerOneScore = 0,
    this.playerTwoScore = 0,
    this.addButtonEnabled = false,
  });

  Set copyWith({
    int? set,
    int? playerOneScore,
    int? playerTwoScore,
    bool? addButtonEnabled,
  }) {
    return Set(
      set: set ?? this.set,
      playerOneScore: playerOneScore ?? this.playerOneScore,
      playerTwoScore: playerTwoScore ?? this.playerTwoScore,
      addButtonEnabled: addButtonEnabled ?? this.addButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [set, playerOneScore, playerTwoScore, addButtonEnabled];

}
