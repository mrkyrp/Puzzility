import 'package:json_annotation/json_annotation.dart';
import 'package:puzzility/model/Constants.dart';

part 'Player.g.dart';

@JsonSerializable()
class Player {
  int coins;
  bool isSoundOn;
  bool isNotificationOn;

  Player(
      {this.coins = HINT_PRICE, this.isSoundOn = true, this.isNotificationOn = true});
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
