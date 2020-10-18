import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/AlertDialogController.dart';
import 'package:puzzility/components/ButtonWithBorder.dart';
import 'package:puzzility/components/RemainingCoin.dart';
import 'package:puzzility/model/Constants.dart';
import 'package:puzzility/model/Puzzle.dart';
import 'package:puzzility/model/UnlockedPuzzle.dart';
import 'package:puzzility/service/PlayerRepository.dart';
import 'package:puzzility/service/PuzzleRepository.dart';
import 'package:puzzility/views/hint/HintView.dart';
import 'package:puzzility/views/puzzle_list/PuzzleListView.dart';
import 'dart:math';

import 'package:puzzility/views/result/ResultView.dart';

class PuzzleView extends StatefulWidget {
  Puzzle puzzle;
  UnlockedPuzzle unlockedPuzzle;
  PuzzleView(this.puzzle, this.unlockedPuzzle);
  @override
  _PuzzleViewState createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> {
  FocusNode _focusNode = FocusNode();
  AlertDialogController alertController;

  final answerTextController = TextEditingController();
  Color textFieldColor = Colors.transparent;
  Color choiceColor = Colors.transparent;
  int totalStars = 3;
  Map<String, Color> choiceColors = {};

  @override
  void initState() {
    super.initState();
  }

  Widget _buildPuzzleTextView() {
    return Container(
        padding: EdgeInsets.only(bottom: 15.0),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height /
              (widget.puzzle.choices.length > 0 ? 2.75 : 1.75),
        ),
        child: SingleChildScrollView(
          child: Text(widget.puzzle.puzzleText,
              style: Theme.of(context).textTheme.bodyText1),
        ));
  }

  _onClearTextFieldTapped() {
    answerTextController.clear();
  }

  _onSubmitAnswerTapped() async {
    String answer = answerTextController.text;
    if (answer == widget.puzzle.answer) {
      setState(() {
        textFieldColor = ThemeProvider().green();
      });

      await Provider.of<PuzzleRepository>(context, listen: false)
          .completePuzzle(widget.puzzle, totalStars);
      Timer(Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ResultView(widget.puzzle),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      });
    } else {
      setState(() {
        textFieldColor = ThemeProvider().red();
      });
      print("chck total stars ${totalStars}");
      if (totalStars > 1) {
        totalStars -= 1;
        await Provider.of<PuzzleRepository>(context, listen: false)
            .setStar(widget.puzzle, totalStars);
      }

      Timer(Duration(milliseconds: 500), () {
        setState(() {
          textFieldColor = Colors.transparent;
        });
        _onClearTextFieldTapped();
      });
    }
  }

  onAnswerChoiceTap(String answer) async {
    if (answer == widget.puzzle.answer) {
      await Provider.of<PuzzleRepository>(context, listen: false)
          .completePuzzle(widget.puzzle, totalStars);
      setState(() {
        choiceColors[answer] = ThemeProvider().green();
      });

      Timer(Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ResultView(widget.puzzle),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      });
    } else {
      if (totalStars > 1) {
        totalStars -= 1;
        await Provider.of<PuzzleRepository>(context, listen: false)
            .setStar(widget.puzzle, totalStars);
      }
      setState(() {
        choiceColors[answer] = ThemeProvider().red();
      });

      Timer(Duration(milliseconds: 500), () {
        setState(() {
          choiceColors[answer] = Colors.transparent;
        });
      });
    }
  }

  _watchVideoAds() {}

  _dismissKeyboard(String text) {
    FocusManager.instance.primaryFocus.unfocus();
  }

  _navigateToHints() {
    widget.unlockedPuzzle.unlockedHints[0]
        ? Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) =>
                  HintView(widget.puzzle, widget.unlockedPuzzle),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          )
        : alertController.showAlertDialog(
            message: "Unlock this hint for $HINT_PRICE coins",
            cancelActionTitle: "cancel",
            okActionTitle: "Unlock",
            onOkPressed: () {
              Navigator.pop(context);
              _onUnlockHint(0);
            });
  }

  _onUnlockHint(int index) async {
    await Provider.of<PuzzleRepository>(context, listen: false)
        .unlockHint(index, widget.puzzle);
    await Provider.of<PlayerRepository>(context, listen: false)
        .subtractCoin(HINT_PRICE);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) =>
            HintView(widget.puzzle, widget.unlockedPuzzle),
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
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: widget.puzzle.choices.length > 0
          ? Column(
              children: widget.puzzle.choices.map((choice) {
              if (choiceColors.length < 4) {
                choiceColors.addAll({choice: Colors.transparent});
              }
              return Container(
                  padding: EdgeInsets.all(5.0),
                  child: ButtonWithBorder(
                    choice,
                    bgColor: choiceColors[choice],
                    onTap: () {
                      onAnswerChoiceTap(choice);
                    },
                  ));
            }).toList())
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
                    _onClearTextFieldTapped),
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
                      color: textFieldColor,
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                      focusNode: _focusNode,
                      onSubmitted: _dismissKeyboard,
                      controller: answerTextController,
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
                    _onSubmitAnswerTapped),
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
    alertController = AlertDialogController(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => PuzzleListView(),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          },
        ),
        actions: [
          Consumer<PlayerRepository>(builder: (context, playerRepo, child) {
            return RemainingCoin(playerRepo.player.coins);
          })
        ],
        backgroundColor: ThemeProvider().darkBlue(),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      height: max(500, constraints.maxHeight)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildPuzzleTextView(),
                      _buildAnswerSection(),
                      Spacer(),
                      _buildBottomBarSection(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
