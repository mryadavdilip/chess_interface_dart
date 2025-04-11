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
  /// It should be used to show the promotion dialog when a pawn reaches the last rank, or pawn on the last rank is tapped. Use [ChessBoardInterface].promotePawn([Position], [PieceType]) to promote the pawn.
  final Future<bool> Function(Position position)? onPromotion;

  /// callback when game is over. must return true/false to check and update state if game is reset or not
  final Future<bool> Function(GameOverBy)? onGameOver;

  Arbiter({this.onGameOver, this.onPromotion});

  /// countdown for player time, if [game] has [timeLimit]
  /// is being used in [ChessBoardWidget] to start [countdownSpectator] when widget is created
  void countdownSpectator(game) {
    StreamSubscription<int>? whiteTimeSubscription;
    StreamSubscription<int>? blackTimeSubscription;

    if (game.timeLimit != null) {
      whiteTimeSubscription = game.whiteTimeStream.listen((countdown) {
        if (countdown <= 0) {
          game.switchTimer(stop: true);
          whiteTimeSubscription?.cancel();

          spectateForGameEnd(game);
        }
      });

      blackTimeSubscription = game.blackTimeStream.listen((countdown) {
        if (countdown <= 0) {
          game.switchTimer(stop: true);
          blackTimeSubscription?.cancel();

          spectateForGameEnd(game);
        }
      });
    }
  }

  /// returns if player chose a piece (isPromoted)
  Future<bool> promotionCheck(
    ChessBoardInterface game,
    Position position,
  ) async {
    if (game.isEligibleForPromotion(position)) {
      if (onPromotion != null) {
        return await onPromotion!(position);
      }
    }
    return false;
  }

  /// returns if game is over (isReset)
  Future<bool> spectateForGameEnd(ChessBoardInterface game) async {
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

    if (gameOverBy != null) {
      if (onGameOver != null) {
        onGameOver!(gameOverBy);
      }
    }

    return false;
  }
}
