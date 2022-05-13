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
    if (!(state.currentSet.playerOneScore >= 11 &&
        state.currentSet.playerOneScore - state.currentSet.playerTwoScore >= 1
    )) {
      emitter(
          state.copyWith(
              currentSet: state.currentSet.copyWith(
                playerOneScore: state.currentSet.playerOneScore + 1,
                addButtonEnabled: false,
              )
          )
      );
    } else {
      emitter(
          state.copyWith(
              currentSet: state.currentSet.copyWith(
                addButtonEnabled: true,
              )
          )
      );
    }
  }

  void _addPlayerTwoSetPoint(
      AddPlayerTwoSetPoint event, Emitter<AddGameState> emitter) {
    if (!(state.currentSet.playerTwoScore >= 11 &&
        state.currentSet.playerTwoScore - state.currentSet.playerOneScore >= 1
    )) {
      emitter(
          state.copyWith(
              currentSet: state.currentSet.copyWith(
                playerTwoScore: state.currentSet.playerTwoScore + 1,
                addButtonEnabled: false,
              )
          )
      );
    } else {
      emitter(
          state.copyWith(
              currentSet: state.currentSet.copyWith(
                addButtonEnabled: true,
              )
          )
      );
    }
  }

  void _removePlayerOneSetPoint(
      RemovePlayerOneSetPoint event, Emitter<AddGameState> emitter) {
    if (state.currentSet.playerOneScore > 0) {
      if (state.currentSet.playerOneScore > state.currentSet.playerTwoScore) {
        emitter(
            state.copyWith(
                currentSet: state.currentSet.copyWith(
                  playerOneScore: state.currentSet.playerOneScore - 1,
                  addButtonEnabled: state.currentSet.addButtonEnabled ? false : state.currentSet.addButtonEnabled
                )
            )
        );
      } else {
        emitter(
            state.copyWith(
                currentSet: state.currentSet.copyWith(
                  playerOneScore: state.currentSet.playerOneScore - 1,
                )
            )
        );
      }
    }
  }

  void _removePlayerTwoSetPoint(
      RemovePlayerTwoSetPoint event, Emitter<AddGameState> emitter) {
    if (state.currentSet.playerTwoScore > 0) {
      if (state.currentSet.playerTwoScore > state.currentSet.playerOneScore) {
        emitter(
            state.copyWith(
                currentSet: state.currentSet.copyWith(
                  playerTwoScore: state.currentSet.playerTwoScore - 1,
                    addButtonEnabled: state.currentSet.addButtonEnabled ? false : state.currentSet.addButtonEnabled,
                )
            )
        );
      } else {
        emitter(
            state.copyWith(
                currentSet: state.currentSet.copyWith(
                  playerTwoScore: state.currentSet.playerTwoScore - 1,
                )
            )
        );
      }
    }
  }
}

extension GameStatusX on GameStatus {
  bool get isInitialized => this == GameStatus.initialized;

  bool get isStarted => this == GameStatus.started;

  bool get isCanceled => this == GameStatus.canceled;

  bool get isFinished => this == GameStatus.finished;
}
