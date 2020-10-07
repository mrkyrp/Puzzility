import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/ButtonWithBorder.dart';
import 'package:puzzility/components/GradientButton.dart';
import 'package:puzzility/components/RemainingCoin.dart';
import 'package:puzzility/model/Puzzle.dart';
import 'package:puzzility/model/UnlockedPuzzle.dart';
import 'package:puzzility/service/PuzzleRepository.dart';

class ResultView extends StatelessWidget {
  Puzzle puzzle;
  UnlockedPuzzle unlockedPuzzle;

  ResultView(this.puzzle);

  Widget _circularButton(Icon icon, Color color, VoidCallback onTap,
      {double width, double height}) {
    return Container(
      width: width ?? 40,
      height: height ?? 40,
      // padding: EdgeInsets.only(left: 4.0, right: 4.0),
      child: ClipOval(
        child: Container(
          color: color,
          child: InkWell(
            child: SizedBox(
                width: width != null ? width - 10 : 30,
                height: height != null ? height - 10 : 30,
                child: icon),
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  _watchVideoAds() {}

  _navigateToNextPuzzle(BuildContext context) {
    // if (puzzle.puzzleNo < _puzzleRepository.puzzleList.length) {
    //   Navigator.push(
    //     context,
    //     PageRouteBuilder(
    //       pageBuilder: (c, a1, a2) =>
    //           PuzzleView(_puzzleRepository.puzzleList[puzzle.puzzleNo - 1]),
    //       transitionsBuilder: (c, anim, a2, child) =>
    //           FadeTransition(opacity: anim, child: child),
    //       transitionDuration: Duration(milliseconds: 300),
    //     ),
    //   );
    // }
  }

  Widget _buildBottomBarSection() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(),
          _circularButton(
              Icon(
                FontAwesomeIcons.film,
                color: Colors.white,
                size: 35,
              ),
              ThemeProvider().gold(),
              _watchVideoAds,
              width: 60,
              height: 60),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    unlockedPuzzle = Provider.of<PuzzleRepository>(context).unlockedPuzzleList[
        Provider.of<PuzzleRepository>(context)
            .unlockedPuzzleList
            .indexWhere((element) => element.puzzleNo == puzzle.puzzleNo)];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Puzzle ${puzzle.puzzleNo}"),
        actions: [RemainingCoin()],
        backgroundColor: ThemeProvider().darkBlue(),
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(puzzle.resultText,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 24),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: ButtonWithBorder("Share Result")),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: GradientButton("Next Puzzle", onTap: () {
                    _navigateToNextPuzzle(context);
                  },
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                Spacer(),
                _buildBottomBarSection()
              ],
            )),
      ),
    );
  }
}
