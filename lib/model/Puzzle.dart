import 'package:puzzility/model/PuzzleType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Puzzle.g.dart';

@JsonSerializable()
class Puzzle {
  int puzzleNo;
  String title;
  bool isUnlocked;
  String puzzleText;
  String answer;
  String resultText;
  String type;
  @JsonKey(unknownEnumValue: PuzzleType.Type)
  PuzzleType puzzleType;
  List<String> hints;
  List<String> choices;

  Puzzle(this.puzzleNo, this.title, this.puzzleText, this.answer,
      this.resultText, this.type, this.puzzleType, this.hints,
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
  factory Puzzle.fromJson(Map<String, dynamic> json) => _$PuzzleFromJson(json);
  Map<String, dynamic> toJson() => _$PuzzleToJson(this);
}
