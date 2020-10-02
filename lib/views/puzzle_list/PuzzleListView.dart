import 'package:flutter/material.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/PuzzleCell.dart';
import 'package:puzzility/model/Puzzle.dart';
import 'package:puzzility/service/PuzzleRepository.dart';

class PuzzleListView extends StatefulWidget {
  @override
  _PuzzleListViewState createState() => _PuzzleListViewState();
}

class _PuzzleListViewState extends State<PuzzleListView> {
  PuzzleRepository _puzzleRepository = PuzzleRepository();
  List<Puzzle> puzzleList = [];

  List<Widget> _buildQuestionList() {
    return puzzleList.map((puzzle) => PuzzleCell(puzzle)).toList();
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  setup() async {
    List<Puzzle> list = await _puzzleRepository.setup();
    setState(() {
      puzzleList.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: ThemeProvider().darkBlue(),
      child: puzzleList.length > 0
          ? ListView.separated(
            shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return PuzzleCell(puzzleList[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount:
                  puzzleList.length) //ListView(children: _buildQuestionList(),)
          : SizedBox(
              width: 0,
              height: 0,
            ),
    );
  }
}
