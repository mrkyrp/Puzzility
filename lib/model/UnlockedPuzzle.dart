import 'package:json_annotation/json_annotation.dart';

part 'UnlockedPuzzle.g.dart';

@JsonSerializable()
class UnlockedPuzzle {
  int puzzleNo;
  int stars;
  var unlockedHints;
  bool isCompleted;

  UnlockedPuzzle(this.puzzleNo,
      {this.stars = 0, this.unlockedHints, this.isCompleted = false}){
        if(unlockedHints == null){
          unlockedHints = [false,false,false];
        }
      }
  factory UnlockedPuzzle.fromJson(Map<String, dynamic> json) =>
      _$UnlockedPuzzleFromJson(json);
  Map<String, dynamic> toJson() => _$UnlockedPuzzleToJson(this);
}
