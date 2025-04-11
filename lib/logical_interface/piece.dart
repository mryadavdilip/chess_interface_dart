/// Chess pieces
enum PieceType { pawn, knight, bishop, rook, queen, king }

/// Piece colors / Players
enum PieceColor { white, black }

/// A single chess piece of a player
class ChessPiece {
  final PieceType type;
  final PieceColor color;

  ChessPiece({required this.type, required this.color});
}
