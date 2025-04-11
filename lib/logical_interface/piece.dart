enum PieceType { pawn, knight, bishop, rook, queen, king }

enum PieceColor { white, black }

class ChessPiece {
  final PieceType type;
  final PieceColor color;

  ChessPiece({required this.type, required this.color});
}
