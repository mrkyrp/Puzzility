import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  // List<Widget> _buildQuestionList(BuildContext context) {
  //   return Provider.of<PuzzleRepository>(context)
  //       .puzzleList
  //       .map((puzzle) => PuzzleCell(puzzle))
  //       .toList();
  // }

  @override
  void initState() {
    super.initState();

    // setup();
  }

  // setup() async {
  //   await _puzzleRepository.setup();
  // }

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

  onPuzzleCellTapped(int index, BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => PuzzleView(
            Provider.of<PuzzleRepository>(context).puzzleList[index],
            Provider.of<PuzzleRepository>(context).unlockedPuzzleList[index]),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PuzzleRepository>(builder: (context, repository, child) {
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
            child: repository.puzzleList.length > 0
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return PuzzleCell(
                        repository.puzzleList[index],
                        isUnlocked: repository.isUnlock(index),
                        stars: repository.unlockedPuzzleList[index].isCompleted
                            ? repository.getStars(index)
                            : 0,
                        onTap: () {
                          onPuzzleCellTapped(index, context);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: repository.puzzleList.length)
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
          ),
        ),
      );
    });
  }
}
