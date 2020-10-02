import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/ButtonWithBorder.dart';
import 'package:puzzility/components/RemainingCoin.dart';
import 'package:puzzility/model/Puzzle.dart';
import 'package:puzzility/views/hint/HintView.dart';

class PuzzleView extends StatefulWidget {
  Puzzle puzzle;
  PuzzleView(this.puzzle);
  @override
  _PuzzleViewState createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> {
  Widget _buildPuzzleTextView() {
    return Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height /
            (widget.puzzle.choices.length > 0 ? 2.75 : 2.5),
        child: Text(widget.puzzle.puzzleText,
            style: Theme.of(context).textTheme.bodyText1));
  }

  _onClearTextFieldTapped() {}

  _onSubmitAnswerTapped() {}

  _watchVideoAds() {}

  _navigateToHints() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => HintView(widget.puzzle),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

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

  Widget _buildAnswerSection() {
    print(widget.puzzle.choices);
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: widget.puzzle.choices.length > 0
          ? Column(
              children: widget.puzzle.choices
                  .map((choice) => Container(
                      padding: EdgeInsets.all(5.0),
                      child: ButtonWithBorder(choice)))
                  .toList())
          : Row(
              children: <Widget>[
                SizedBox(
                  width: 8.0,
                ),
                _circularButton(
                    Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    ThemeProvider().red(),
                    _onSubmitAnswerTapped),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 4.0, color: ThemeProvider().blueBorder()),
                      color: Colors.transparent,
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Answer here",
                          hintStyle: Theme.of(context).textTheme.headline3),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                _circularButton(
                    Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 30,
                    ),
                    ThemeProvider().green(),
                    _onClearTextFieldTapped),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
    );
  }

  Widget _buildBottomBarSection() {
    return Container(
      child: Row(
        children: <Widget>[
          _circularButton(
              Icon(
                Icons.search,
                color: Colors.white,
                size: 40,
              ),
              ThemeProvider().pink(),
              _navigateToHints,
              width: 60,
              height: 60),
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [RemainingCoin()],
        backgroundColor: ThemeProvider().darkBlue(),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _buildPuzzleTextView(),
              _buildAnswerSection(),
              Spacer(),
              _buildBottomBarSection(),
            ],
          ),
        ),
      ),
    );
  }
}
