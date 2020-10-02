import 'package:flutter/material.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/PuzzleCell.dart';
import 'package:puzzility/components/RemainingCoin.dart';
import 'package:puzzility/model/Puzzle.dart';
import 'package:puzzility/service/PuzzleRepository.dart';
import 'package:puzzility/views/puzzle_view/PuzzleView.dart';
import 'package:puzzility/views/setting/SettingView.dart';

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

  onSettingTapped() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => SettingView(),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

  onPuzzleCellTapped(int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => PuzzleView(puzzleList[index]),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: onSettingTapped,
        ),
        actions: [RemainingCoin()],
        backgroundColor: ThemeProvider().darkBlue(),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: ThemeProvider().darkBlue(),
          child: puzzleList.length > 0
              ? ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return PuzzleCell(
                      puzzleList[index],
                      onTap: () {
                        onPuzzleCellTapped(index);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: puzzleList
                      .length) //ListView(children: _buildQuestionList(),)
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
        ),
      ),
    );
  }
}
