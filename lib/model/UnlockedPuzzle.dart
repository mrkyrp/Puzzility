import 'package:json_annotation/json_annotation.dart';

part 'UnlockedPuzzle.g.dart';

@JsonSerializable()
class UnlockedPuzzle {
  int puzzleNo;
  int stars;
  List<bool> unlockedHints;
  bool isCompleted;

  UnlockedPuzzle(this.puzzleNo,
      {this.stars = 0, this.unlockedHints, this.isCompleted = false});
  factory UnlockedPuzzle.fromJson(Map<String, dynamic> json) =>
      _$UnlockedPuzzleFromJson(json);
  Map<String, dynamic> toJson() => _$UnlockedPuzzleToJson(this);
}
