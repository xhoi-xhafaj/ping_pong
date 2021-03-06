import 'dart:async';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ping_pong/add_games/add_games.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'add_game_state.dart';

part 'add_game_event.dart';

class AddGameBloc extends Bloc<AddGameEvent, AddGameState> {
  AddGameBloc({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(const AddGameState()) {
    on<GetListOfOpponents>(_onGetOpponentsList);
    on<ChangePlayerOne>(_onChangePlayerOne);
    on<ChangePlayerTwo>(_onChangePlayerTwo);
    on<ChangeTypeOfGame>(_onChangeTypeOfGame);
    on<InitializeNewGame>(_onInitializeNewGame);
    on<AddPlayerOneSetPoint>(_addPlayerOneSetPoint);
    on<AddPlayerTwoSetPoint>(_addPlayerTwoSetPoint);
    on<RemovePlayerOneSetPoint>(_removePlayerOneSetPoint);
    on<RemovePlayerTwoSetPoint>(_removePlayerTwoSetPoint);
    on<AddSet>(_onAddSet);
    on<CancelGame>(_onCancelGame);
    on<SaveGame>(_onSaveGame);
  }

  final FirestoreRepository _firestoreRepository;

  void _onGetOpponentsList(
      GetListOfOpponents event, Emitter<AddGameState> emitter) async {
    List<UserInfo> allPlayers = await _firestoreRepository.getUsernames();
    List<String> allUsernamesPlayer = <String>[];
    for (var player in allPlayers) {
      allUsernamesPlayer.add(player.username);
    }
    final UserInfo currentPlayer = _firestoreRepository.currentUsername;
    emitter(state.copyWith(
      players: allUsernamesPlayer,
      playerOne:
          state.playerOne.isEmpty ? currentPlayer.username : state.playerOne,
    ));
  }

  void _onChangePlayerOne(
      ChangePlayerOne event, Emitter<AddGameState> emitter) {
    emitter(state.copyWith(playerOne: event.playerOne));
  }

  void _onChangePlayerTwo(
      ChangePlayerTwo event, Emitter<AddGameState> emitter) {
    emitter(state.copyWith(playerTwo: event.playerTwo));
  }

  void _onChangeTypeOfGame(
      ChangeTypeOfGame event, Emitter<AddGameState> emitter) {
    emitter(state.copyWith(
        gameTypeBestOf: GameType.values.byName(event.typeOfGame)));
  }

  void _onInitializeNewGame(
      InitializeNewGame event, Emitter<AddGameState> emitter) async {
    if (state.playerOne.isNotEmpty &&
        state.playerTwo.isNotEmpty &&
        state.gameTypeBestOf.name.isNotEmpty &&
        state.gameStatus == GameStatus.initialized) {
      var docId = await _firestoreRepository.initializeNewGame(GameInfo(
          playerOne: state.playerOne,
          playerTwo: state.playerTwo,
          gameStatus: GameStatus.started,
          gameTypeBestOf: state.gameTypeBestOf,
          winner: state.winner,
          winSetPlayerTwo: state.winSetPlayerTwo,
          winSetPlayerOne: state.winSetPlayerTwo));
      if (docId.isNotEmpty) {
        emitter(state.copyWith(
            documentId: docId,
            gameStatus: GameStatus.started,
            currentSet: state.currentSet.copyWith(set: 1)));
      }
    }
  }

  void _addPlayerOneSetPoint(
      AddPlayerOneSetPoint event, Emitter<AddGameState> emitter) {
    int futureScorePlayerOne = state.currentSet.playerOneScore + 1;
    int futureScorePlayerTwo = state.currentSet.playerTwoScore;

    if (checkIfSetFinished(futureScorePlayerOne, futureScorePlayerTwo)) {
      if (state.currentSet.addButtonEnabled) {
        if (futureScorePlayerTwo >= futureScorePlayerOne + 2) {
          emitter(state.copyWith(
              currentSet: state.currentSet.copyWith(
            playerOneScore: futureScorePlayerOne,
            addButtonEnabled: true,
          )));
        } else {
          emitter(state.copyWith(
              currentSet: state.currentSet.copyWith(
            addButtonEnabled: true,
          )));
        }
      } else {
        emitter(state.copyWith(
            currentSet: state.currentSet.copyWith(
          playerOneScore: futureScorePlayerOne,
          addButtonEnabled: true,
        )));
      }
    } else {
      emitter(state.copyWith(
          currentSet: state.currentSet.copyWith(
        playerOneScore: futureScorePlayerOne,
        addButtonEnabled: false,
      )));
    }
  }

  void _addPlayerTwoSetPoint(
      AddPlayerTwoSetPoint event, Emitter<AddGameState> emitter) {
    int futureScorePlayerOne = state.currentSet.playerOneScore;
    int futureScorePlayerTwo = state.currentSet.playerTwoScore + 1;

    if (checkIfSetFinished(futureScorePlayerOne, futureScorePlayerTwo)) {
      if (state.currentSet.addButtonEnabled) {
        if (futureScorePlayerOne >= futureScorePlayerTwo + 2) {
          emitter(state.copyWith(
              currentSet: state.currentSet.copyWith(
            playerTwoScore: futureScorePlayerTwo,
            addButtonEnabled: true,
          )));
        } else {
          emitter(state.copyWith(
              currentSet: state.currentSet.copyWith(
            addButtonEnabled: true,
          )));
        }
      } else {
        emitter(state.copyWith(
            currentSet: state.currentSet.copyWith(
          playerTwoScore: futureScorePlayerTwo,
          addButtonEnabled: true,
        )));
      }
    } else {
      emitter(state.copyWith(
          currentSet: state.currentSet.copyWith(
        playerTwoScore: futureScorePlayerTwo,
        addButtonEnabled: false,
      )));
    }
  }

  void _removePlayerOneSetPoint(
      RemovePlayerOneSetPoint event, Emitter<AddGameState> emitter) {
    int futureScorePlayerOne = state.currentSet.playerOneScore - 1;
    int futureScorePlayerTwo = state.currentSet.playerTwoScore;

    if (state.currentSet.playerOneScore != 0) {
      if (checkIfSetFinished(futureScorePlayerOne, futureScorePlayerTwo)) {
        if (futureScorePlayerOne + 3 > futureScorePlayerTwo) {
          emitter(state.copyWith(
              currentSet: state.currentSet.copyWith(
            playerOneScore: futureScorePlayerOne,
            addButtonEnabled: true,
          )));
        }
      } else {
        emitter(state.copyWith(
            currentSet: state.currentSet.copyWith(
          playerOneScore: futureScorePlayerOne,
          addButtonEnabled: false,
        )));
      }
    }
  }

  void _removePlayerTwoSetPoint(
      RemovePlayerTwoSetPoint event, Emitter<AddGameState> emitter) {
    int futureScorePlayerOne = state.currentSet.playerOneScore;
    int futureScorePlayerTwo = state.currentSet.playerTwoScore - 1;

    if (state.currentSet.playerTwoScore != 0) {
      if (checkIfSetFinished(futureScorePlayerOne, futureScorePlayerTwo)) {
        if (futureScorePlayerTwo + 3 > futureScorePlayerOne) {
          emitter(state.copyWith(
              currentSet: state.currentSet.copyWith(
            playerTwoScore: futureScorePlayerTwo,
            addButtonEnabled: true,
          )));
        }
      } else {
        emitter(state.copyWith(
          currentSet: state.currentSet.copyWith(
            playerTwoScore: futureScorePlayerTwo,
            addButtonEnabled: false,
          ),
        ));
      }
    }
  }

  void _onAddSet(AddSet event, Emitter<AddGameState> emitter) async {
    int playerOneScore = state.winSetPlayerOne;
    int playerTwoScore = state.winSetPlayerTwo;
    bool hasFinished = false;
    GameStatus status = GameStatus.started;
    String winner = "";

    if (state.currentSet.playerOneScore > state.currentSet.playerTwoScore) {
      playerOneScore += 1;
    } else {
      playerTwoScore += 1;
    }

    if (playerOneScore == state.gameTypeBestOf.toNeededSetToWin ||
        playerTwoScore == state.gameTypeBestOf.toNeededSetToWin) {
      hasFinished = true;
      status = GameStatus.finished;
    }

    if (hasFinished) {
      if (playerOneScore > playerTwoScore) {
        winner = state.playerOne;
      } else {
        winner = state.playerTwo;
      }
    }

    try {
      _firestoreRepository.addSetToMatch(
          state.documentId,
          SetScore(
            set: "set_" + state.currentSet.set.toString(),
            playerOne: state.playerOne,
            playerTwo: state.playerTwo,
            setScorePlayerOne: state.currentSet.playerOneScore,
            setScorePlayerTwo: state.currentSet.playerTwoScore,
          ),
          playerOneScore,
          playerTwoScore,
          status.name,
          winner);
      emitter(state.copyWith(
        currentSet: state.currentSet.copyWith(
          set: hasFinished ? 0 : state.currentSet.set + 1,
          playerOneScore: 0,
          playerTwoScore: 0,
          addButtonEnabled: false,
        ),
        winSetPlayerOne: playerOneScore,
        winSetPlayerTwo: playerTwoScore,
        winner: winner,
        gameStatus: status,
        savedSets: List.of(state.savedSets)..add(state.currentSet),
      ));
    } catch (e) {
      rethrow;
    }
  }

  void _onSaveGame(SaveGame event, Emitter<AddGameState> emitter) {
    emitter(state.copyWith(
      gameStatus: GameStatus.saved,
    ));

  }

  void _onCancelGame(CancelGame event, Emitter<AddGameState> emitter) async {
    if (state.documentId.isEmpty) {
      emitter(state.copyWith(gameStatus: GameStatus.canceled));
    } else {
      bool deleted =
          await _firestoreRepository.deleteGameDocument(state.documentId);
      print(deleted);
      if (deleted == true) {
        emitter(state.copyWith(gameStatus: GameStatus.canceled));
      }
    }
  }

  bool checkIfSetFinished(int scoreOne, int scoreTwo) {
    if (scoreOne >= 11 && scoreOne - scoreTwo >= 2) {
      return true;
    } else if (scoreTwo >= 11 && scoreTwo - scoreOne >= 2) {
      return true;
    } else {
      return false;
    }
  }
}

extension GameStatusX on GameStatus {
  bool get isInitialized => this == GameStatus.initialized;

  bool get isStarted => this == GameStatus.started;

  bool get isCanceled => this == GameStatus.canceled;

  bool get isFinished => this == GameStatus.finished;

  bool get isSaved => this == GameStatus.saved;
}

extension GameTypeX on GameType {
  int get toNeededSetToWin {
    switch (this) {
      case GameType.three:
        return 2;
      case GameType.five:
        return 3;
      case GameType.seven:
        return 4;
      default:
        return 0;
    }
  }
}
