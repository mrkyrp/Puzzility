import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:puzzility/model/Puzzle.dart';

class PuzzleRepository {
  List<Puzzle> puzzleList = new List();

  Future<List<Puzzle>> setup() async {
    ByteData data = await rootBundle.load("assets/data/puzzle_list.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      for (var row in excel.tables[table].rows.sublist(1)) {
        print("$row");
        List<String> hints = [
          row[6].toString(),
          row[7].toString(),
          row[8].toString()
        ];
        puzzleList.add(Puzzle(
            row[0].toInt(), row[1], row[2], row[4].toString(), row[3], hints,
            choices: row[5] != null ? row[5].toString().split(",") : []));
      }
    }
    return puzzleList;
  }
}
