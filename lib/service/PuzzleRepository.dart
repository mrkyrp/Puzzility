import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puzzility/model/Puzzle.dart';
import 'package:puzzility/model/PuzzleType.dart';
import 'package:puzzility/model/UnlockedPuzzle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PuzzleRepository extends ChangeNotifier {
  List<Puzzle> puzzleList = [];
  List<UnlockedPuzzle> unlockedPuzzleList = [];
  PuzzleRepository() {
    setup();
  }

  Future<List<Puzzle>> setupPuzzleList() async {
    ByteData data = await rootBundle.load("assets/data/puzzle_list.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      // print(table); //sheet Name
      for (var row in excel.tables[table].rows.sublist(1)) {
        // print("${row.length}");
        List<String> hints = [
          row[6].toString(),
          row[7].toString(),
          row[8].toString()
        ];
        puzzleList.add(Puzzle(row[0].toInt(), row[1], row[2], row[4].toString(),
            row[9], row[3], convertTypeToEnum(row[3]), hints,
            choices: row[5] != null ? row[5].toString().split(",") : []));
      }
    }
    return puzzleList;
  }

  unlockHint(int index, Puzzle puzzle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int unlockPuzzleIndex = unlockedPuzzleList
        .indexWhere((element) => element.puzzleNo == puzzle.puzzleNo);
    unlockedPuzzleList[unlockPuzzleIndex].unlockedHints[index] = true;

    String data = json.encode(
      unlockedPuzzleList
          .map<Map<String, dynamic>>((element) => element.toJson())
          .toList(),
    );
    prefs.setString("unlockedPuzzle", data).then((bool success) {
      return success;
    });
    notifyListeners();
  }

  bool isUnlock(int index) {
    if (unlockedPuzzleList.length > 0) {
      UnlockedPuzzle puzzle = unlockedPuzzleList.firstWhere(
          (puzzle) => puzzle.puzzleNo == puzzleList[index].puzzleNo);
      return puzzle != null ? true : false;
    }
    return false;
  }

  int getStars(int index) {
    if (unlockedPuzzleList.length > 0) {
      UnlockedPuzzle puzzle = unlockedPuzzleList.firstWhere(
          (puzzle) => puzzle.puzzleNo == puzzleList[index].puzzleNo);
      return puzzle != null ? puzzle.stars : 0;
    }
    return 0;
  }

  Future<List<UnlockedPuzzle>> setupUnlockedPuzzle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('unlockedPuzzle') ?? "";
    if (data != "") {
      List<UnlockedPuzzle> result = (json.decode(data) as List<dynamic>)
          .map<UnlockedPuzzle>((item) => UnlockedPuzzle.fromJson(item))
          .toList();
      this.unlockedPuzzleList.addAll(result);
      return result;
    } else {
      int i = 1;
      while (i <= 10) {
        this.unlockedPuzzleList.add(UnlockedPuzzle(i));
        i++;
      }
      return this.unlockedPuzzleList;
    }
  }

  completePuzzle(Puzzle puzzle, int stars) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int index = unlockedPuzzleList
        .indexWhere((element) => element.puzzleNo == puzzle.puzzleNo);
    unlockedPuzzleList[index].isCompleted = true;
    if (unlockedPuzzleList[index].stars == 0 ||
        unlockedPuzzleList[index].stars > stars) {
      unlockedPuzzleList[index].stars = stars;
    }

    String data = json.encode(
      unlockedPuzzleList
          .map<Map<String, dynamic>>((element) => element.toJson())
          .toList(),
    );
    prefs.setString("unlockedPuzzle", data).then((bool success) {
      return success;
    });
    notifyListeners();
  }

  setStar(Puzzle puzzle, int stars) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = unlockedPuzzleList
        .indexWhere((element) => element.puzzleNo == puzzle.puzzleNo);

    unlockedPuzzleList[index].stars = stars;

    String data = json.encode(
      unlockedPuzzleList
          .map<Map<String, dynamic>>((element) => element.toJson())
          .toList(),
    );
    prefs.setString("unlockedPuzzle", data).then((bool success) {
      return success;
    });
    notifyListeners();
  }

  setup() async {
    await setupPuzzleList();
    await setupUnlockedPuzzle();
    notifyListeners();
  }

  PuzzleType convertTypeToEnum(String text) {
    PuzzleType result;
    switch (text) {
      case "Type":
        result = PuzzleType.Type;
        break;
      case "Choice":
        result = PuzzleType.Choice;
        break;
      default:
        break;
    }
    return result;
  }
}
