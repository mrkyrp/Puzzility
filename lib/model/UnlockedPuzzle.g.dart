// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UnlockedPuzzle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnlockedPuzzle _$UnlockedPuzzleFromJson(Map<String, dynamic> json) {
  return UnlockedPuzzle(
    json['puzzleNo'] as int,
    stars: json['stars'] as int,
    unlockedHints:
        (json['unlockedHints'] as List)?.map((e) => e as bool)?.toList(),
    isCompleted: json['isCompleted'] as bool,
  );
}

Map<String, dynamic> _$UnlockedPuzzleToJson(UnlockedPuzzle instance) =>
    <String, dynamic>{
      'puzzleNo': instance.puzzleNo,
      'stars': instance.stars,
      'unlockedHints': instance.unlockedHints,
      'isCompleted': instance.isCompleted,
    };
