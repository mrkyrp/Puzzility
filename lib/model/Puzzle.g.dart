// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Puzzle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Puzzle _$PuzzleFromJson(Map<String, dynamic> json) {
  return Puzzle(
    json['puzzleNo'] as int,
    json['title'] as String,
    json['puzzleText'] as String,
    json['answer'] as String,
    json['resultText'] as String,
    json['type'] as String,
    _$enumDecodeNullable(_$PuzzleTypeEnumMap, json['puzzleType'],
        unknownValue: PuzzleType.Type),
    (json['hints'] as List)?.map((e) => e as String)?.toList(),
    choices: (json['choices'] as List)?.map((e) => e as String)?.toList(),
  )..isUnlocked = json['isUnlocked'] as bool;
}

Map<String, dynamic> _$PuzzleToJson(Puzzle instance) => <String, dynamic>{
      'puzzleNo': instance.puzzleNo,
      'title': instance.title,
      'isUnlocked': instance.isUnlocked,
      'puzzleText': instance.puzzleText,
      'answer': instance.answer,
      'resultText': instance.resultText,
      'type': instance.type,
      'puzzleType': _$PuzzleTypeEnumMap[instance.puzzleType],
      'hints': instance.hints,
      'choices': instance.choices,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PuzzleTypeEnumMap = {
  PuzzleType.Type: 'Type',
  PuzzleType.Choice: 'Choice',
};
