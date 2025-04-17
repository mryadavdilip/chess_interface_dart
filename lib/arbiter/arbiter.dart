import 'dart:async';

import 'package:chess_interface_dart/logical_interface/interface.dart';

enum GameOverBy {
  checkmate,
  stalemate,
  insufficientMaterial,
  threefoldRepetition,
  fiftyMoveRule,
  draw,
  resign,
  timeOut,
}

class Arbiter {
  /// Callback is made when [checkForGameEnd] satisfy a condition
  void Function(GameOverBy)? onGameOver;

  Arbiter({required this.onGameOver});

  /// countdown for player time, if [game] has [timeLimit]
  /// is being used in [ChessBoardWidget] to start [countdownSpectator] when widget is created
  void countdownSpectator(ChessBoardInterface game) {
    StreamSubscription<int>? whiteTimeSubscription;
    StreamSubscription<int>? blackTimeSubscription;

    if (game.timeLimit != null) {
      whiteTimeSubscription = game.whiteTimeStream.listen((countdown) {
        if (countdown <= 0) {
          game.switchTimer(stop: true);
          whiteTimeSubscription?.cancel();

          checkForGameEnd(game);
        }
      });

      blackTimeSubscription = game.blackTimeStream.listen((countdown) {
        if (countdown <= 0) {
          game.switchTimer(stop: true);
          blackTimeSubscription?.cancel();

          checkForGameEnd(game);
        }
      });
    }
  }

  /// one time spectation
  GameOverBy? checkForGameEnd(ChessBoardInterface game) {
    GameOverBy? gameOverBy;

    if (game.isCheckmate()) {
      gameOverBy = GameOverBy.checkmate;
    } else if (game.isStalemate()) {
      gameOverBy = GameOverBy.stalemate;
    } else if (game.isDraw) {
      gameOverBy = GameOverBy.draw;
    } else if (game.resign != null) {
      gameOverBy = GameOverBy.resign;
    } else if (game.isTimeOut()) {
      gameOverBy = GameOverBy.timeOut;
    } else if (game.isInsufficientMaterial()) {
      gameOverBy = GameOverBy.insufficientMaterial;
    } else if (game.isThreefoldRepetition()) {
      gameOverBy = GameOverBy.threefoldRepetition;
    } else if (game.isFiftyMoveDraw()) {
      gameOverBy = GameOverBy.fiftyMoveRule;
    }

    if (gameOverBy != null && onGameOver != null) {
      onGameOver!(gameOverBy);
    }

    return gameOverBy;
  }
}
