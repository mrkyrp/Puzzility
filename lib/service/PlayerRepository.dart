import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:puzzility/model/Player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerRepository extends ChangeNotifier {
  Player player = Player();
  PlayerRepository() {
    setup();
  }

  setup() async {
    await setupPlayer();
    
    notifyListeners();
  }

  Future<Player> setupPlayer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('currentPlayer') ?? "";
    if (data != "") {
      Player result = Player.fromJson(json.decode(data) as dynamic);
      player = result;
      return result;
    } else {
      player = Player();
      return player;
    }
  }

  Future<bool> subtractCoin(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    player.coins -= amount;

    String data = json.encode(player.toJson());
    await prefs.setString("currentPlayer", data).then((bool success) {
      notifyListeners();
      return success;
    });
    return false;
  }

  Future<bool> addCoin(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    player.coins += amount;

    String data = json.encode(player.toJson());
    await prefs.setString("currentPlayer", data).then((bool success) {
      notifyListeners();
      return success;
    });
    return false;
  }
}
