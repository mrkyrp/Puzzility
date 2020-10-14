import 'package:json_annotation/json_annotation.dart';

part 'Player.g.dart';

@JsonSerializable()
class Player {
  int coins;
  bool isSoundOn;
  bool isNotificationOn;

  Player(
      {this.coins = 50, this.isSoundOn = true, this.isNotificationOn = true});
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
