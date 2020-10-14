// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    coins: json['coins'] as int,
    isSoundOn: json['isSoundOn'] as bool,
    isNotificationOn: json['isNotificationOn'] as bool,
  );
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'coins': instance.coins,
      'isSoundOn': instance.isSoundOn,
      'isNotificationOn': instance.isNotificationOn,
    };
