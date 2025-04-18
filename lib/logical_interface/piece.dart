import 'dart:convert';

import 'package:change_case/change_case.dart';
export 'package:change_case/change_case.dart';

/// Chess pieces
enum PieceType { pawn, knight, bishop, rook, queen, king }

/// Piece colors / Players
enum PieceColor {
  white,
  black;

  String get upperFirstCase => name.toUpperFirstCase();
}

/// A single chess piece of a player
class ChessPiece {
  final PieceType type;
  final PieceColor color;

  ChessPiece({required this.type, required this.color});

  /// Either [String] or [Map<String, dynamic>]
  factory ChessPiece.fromJson(dynamic json) {
    assert(json != null, 'JSON cannot be null');
    assert(
      json is String || json is Map<String, dynamic>,
      'Invalid JSON format for ChessPiece',
    );
    json = (json is String ? jsonDecode(json) : json) as Map<String, dynamic>;

    assert(
      json['type'] != null && json['color'] != null,
      'type or color cannot be null in JSON format for ChessPiece',
    );
    return ChessPiece(
      type: PieceType.values.byName(json['type']),
      color: PieceColor.values.byName(json['color']),
    );
  }

  /// Either [String] or [Map<String, dynamic>]
  T toJson<T>() {
    Map<String, dynamic> map = {'type': type.name, 'color': color.name};

    if (T == String) {
      return jsonEncode(map) as T;
    } else {
      return map as T;
    }
  }
}
