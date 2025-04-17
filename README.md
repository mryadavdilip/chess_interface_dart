[![Buy Me A Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png)](https://www.buymeacoffee.com/mryadavdilip)

# chess_interface_dart

Complete chess functionalities including FEN initialization, en-passant, checkmate and draw rules. This is a pure dart package for backend and doesn't include flutter components for front-end. Visit [chess_interface](https://www.pub.dev/packages/chess_interface) for complete front-end package

## Features

- ✅ Built-in move validation for all standard piece types
- 🔄 Supports en passant, castling, and pawn promotion logic
- 📐 Interface-driven board interaction for flexible state management
- ⏱️ Countdown stream for both players.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  chess_interface_dart:
    git:
      url: https://github.com/mryadavdilip/chess_interface_dart.git
```
OR

```yaml
dependencies:
  chess_interface_dart: ^1.0.7
```

Then import these:

```dart
import 'package:chess_board_widget/logical_interface/interface.dart';
```

## Example

```dart
ChessBoardInterface game = ChessBoardInterface(
    // optional
    fen: 'qkN/p7/8/8/8...',
    
    // optional
    timeLimit: Duration(minutes: 10),
  );
```

### Move Validation

Use `MoveValidator.isValidMove()` to validate legal chess moves:

```dart
bool isValid = MoveValidator.isValidMove(ChessBoardInterface game, Position from, Position to);
```

It supports:
- All standard chess moves
- Pawn special rules
- Castling logic (including history tracking)
- En passant and double pawn pushes

### Arbiter

Arbiter to handle events like game over, time out and pawn promotion:

## And more..

## File Structure

- `arbiter.dart` – Game over, timeOut, and promotion handler
- `interface.dart` – Board interaction interface
- `move_validator.dart` – Move legality checker
- `piece.dart` – Piece model and asset loader

## Contributing
Contributions are welcome! Please open issues and pull requests to help improve this [Package](https://www.github.com/mryadavdilip/chess_interface_dart.git).

## License

MIT License. See [LICENSE](LICENSE) for details.
