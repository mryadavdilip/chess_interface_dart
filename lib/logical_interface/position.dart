import 'dart:convert';

/// To denote [Position] of a peice
class Position {
  final int row;
  final int col;

  Position({required this.row, required this.col});

  /// Either [String] or [Map<String, dynamic>]
  factory Position.fromJson(dynamic json) {
    assert(json != null, 'JSON cannot be null');
    assert(
      json is String || json is Map<String, dynamic>,
      'Invalid JSON format for Position',
    );
    json = (json is String ? jsonDecode(json) : json) as Map<String, dynamic>;

    assert(
      json['row'] != null && json['col'] != null,
      'row or col cannot be null in JSON format for Position',
    );
    return Position(row: json['row']!, col: json['col']!);
  }

  /// Either [String] or [Map<String, dynamic>]
  T toJson<T>() {
    Map<String, dynamic> map = {'row': row, 'col': col};

    if (T == String) {
      return jsonEncode(map) as T;
    } else {
      return map as T;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          col == other.col;

  @override
  int get hashCode => row.hashCode ^ col.hashCode;
}
