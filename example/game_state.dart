import 'package:chess_interface_dart/arbiter/arbiter.dart';
import 'package:chess_interface_dart/logical_interface/interface.dart';
import 'package:chess_interface_dart/logical_interface/move_validator.dart';
import 'package:chess_interface_dart/logical_interface/piece.dart';

ChessBoardInterface game = ChessBoardInterface(
  // optional
  fen: 'qkN/p7/8/8/8...',

  // optional
  timeLimit: Duration(minutes: 10),
);

someFunc() {
  MoveValidator.canCastleKingSide(game, PieceColor.black);
  MoveValidator.canCastleQueenSide(game, PieceColor.black);

  // start spectation for countdown
  Arbiter.countdownSpectator(game);

  // check whether game is over for any reason, draw, checkmate, time-over, etc.
  Arbiter.checkForGameEnd(game);

  // get legal moves for a particular ChessPiece
  game.getValidMoves(Position(row: 5, col: 3));

  // Use this to move a piece with validations
  game.move(Position(row: 3, col: 2), Position(row: 6, col: 2));

  // Use this to move a piece without validation
  game.movePiece(Position(row: 3, col: 2), Position(row: 7, col: 5));

  // Read black player's time left (in seconds)
  game.blackTimeStream.listen((time) {
    print('Black\'s time left: $time');
  });

  // Read white player's time left (in seconds)
  game.whiteTimeStream.listen((time) {
    print('White\'s time left: $time');
  });

  // Which player is to move
  game.turn;

  // To access arrangement of board pieces in 2D List
  game.board;

  // FEN of the current game state
  game.toFEN();

  // En-passant target (when a pawn moves two boxes, e.g., from initial (2nd) rank to 4th rank , it becomes en-passant target)
  game.enPassantTarget;

  // get half move clock (int)
  game.halfMoveClock;

  // get full move number (int)
  game.fullMoveNumber;

  // List of full FEN strings. Doesn't includes current state
  game.history;

  // List of full FEN strings
  game.redoHistory;

  // whether it's draw for any reason
  game.isDraw;

  // verify checkmate state
  game.isCheckmate();

  // check whether pawn on a position, eligible for promotion
  game.isEligibleForPromotion(Position(row: 7, col: 1));

  // check if game state complies with fifty-move draw rule
  game.isFiftyMoveDraw();

  // check whether board has insufficient materials left
  game.isInsufficientMaterial();

  // check whether king is in check
  game.isKingInCheck();

  // check whether it's stalemate
  game.isStalemate();

  // check whether it's threefold repetition
  game.isThreefoldRepetition();

  // check whether timeout for any player
  game.isTimeOut();
}
