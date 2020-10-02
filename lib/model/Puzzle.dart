import 'package:puzzility/model/PuzzleType.dart';

class Puzzle {
  int puzzleNo;
  String title;
  bool isUnlocked;
  String puzzleText;
  String answer;
  String type;
  PuzzleType puzzleType;
  List<String> hints;
  List<String> choices;

  Puzzle(this.puzzleNo, this.title, this.puzzleText, this.answer,this.type, this.hints,
      {this.choices}) {
    switch (type) {
      case "Type":
        this.puzzleType = PuzzleType.Type;
        break;
      case "Choice":
        this.puzzleType = PuzzleType.Choice;
        break;
      default:
        break;
    }
  }
}
