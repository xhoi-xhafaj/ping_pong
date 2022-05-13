part of 'add_game_bloc.dart';

class AddGameEvent extends Equatable {

  const AddGameEvent();

  @override
  List<Object?> get props => [];

}

class GetListOfOpponents extends AddGameEvent {}

class ChangePlayerOne extends AddGameEvent {

  final String playerOne;

  const ChangePlayerOne(this.playerOne);

  @override
  List<Object?> get props => [playerOne];

}

class ChangePlayerTwo extends AddGameEvent {

  final String playerTwo;

  const ChangePlayerTwo(this.playerTwo);

  @override
  List<Object?> get props => [playerTwo];

}

class ChangeTypeOfGame extends AddGameEvent {

  final String typeOfGame;

  const ChangeTypeOfGame(this.typeOfGame);

  @override
  List<Object?> get props => [typeOfGame];

}

class InitializeNewGame extends AddGameEvent {}

class AddPlayerOneSetPoint extends AddGameEvent {}

class AddPlayerTwoSetPoint extends AddGameEvent {}

class RemovePlayerOneSetPoint extends AddGameEvent {}

class RemovePlayerTwoSetPoint extends AddGameEvent {}