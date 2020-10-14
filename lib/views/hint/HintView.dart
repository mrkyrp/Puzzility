import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/AlertDialogController.dart';
import 'package:puzzility/components/RemainingCoin.dart';
import 'package:puzzility/model/Puzzle.dart';
import 'package:puzzility/model/UnlockedPuzzle.dart';
import 'package:puzzility/service/PlayerRepository.dart';
import 'package:puzzility/service/PuzzleRepository.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HintView extends StatefulWidget {
  Puzzle puzzle;
  UnlockedPuzzle unlockedPuzzle;

  HintView(this.puzzle, this.unlockedPuzzle);
  @override
  _HintViewState createState() => _HintViewState();
}

class _HintViewState extends State<HintView>
    with SingleTickerProviderStateMixin {
  AlertDialogController alertController;
  TabController _tabController;

  _onUnlockHint(int index) async {
    await Provider.of<PuzzleRepository>(context, listen: false)
        .unlockHint(index, widget.puzzle);
    await Provider.of<PlayerRepository>(context, listen: false)
        .subtractCoin(50);
    Navigator.pop(context);
  }

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  _onTabBarTapped(int index, BuildContext context) {
    if (index > 0 &&
        !widget.unlockedPuzzle.unlockedHints[index - 1] &&
        !widget.unlockedPuzzle.unlockedHints[index]) {
      alertController.showAlertDialog(
          message:
              "Unlock hint ${index} first, maybe you won't need this one to surpass!",
          okActionTitle: "Okay",
          onOkPressed: () {
            Navigator.pop(context);
            _tabController.index = _tabController.previousIndex;
          });
    } else if (!widget.unlockedPuzzle.unlockedHints[index]) {
      alertController.showAlertDialog(
          message: "Unlock this hint for 50 coins",
          cancelActionTitle: "cancel",
          okActionTitle: "Unlock",
          onCancelPressed: () {
            Navigator.pop(context);
            _tabController.index = _tabController.previousIndex;
          },
          onOkPressed: () {
            _onUnlockHint(index);
          });
    } else {
      _tabController.animateTo(_tabController.index);

    }
  }

  Widget _buildHintTextContainer(int index) {
    return Consumer<PuzzleRepository>(
      builder: (context, playerRepo, child) {
        return playerRepo
                .unlockedPuzzleList[playerRepo.unlockedPuzzleList.indexWhere(
                    (element) =>
                        element.puzzleNo == widget.unlockedPuzzle.puzzleNo)]
                .unlockedHints[index]
            ? Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  widget.puzzle.hints[index],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    alertController = AlertDialogController(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          actions: [
            Consumer<PlayerRepository>(builder: (context, playerRepo, child) {
              return RemainingCoin(playerRepo.player.coins);
            })
          ],
          backgroundColor: ThemeProvider().darkBlue(),
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) {
              _onTabBarTapped(index, context);
            },
            indicator: RectangularIndicator(
              color: ThemeProvider().green(),
              bottomLeftRadius: 100,
              bottomRightRadius: 100,
              topLeftRadius: 100,
              topRightRadius: 100,
            ),
            tabs: [
              Tab(
                child: Text("Hint 1",
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Tab(
                child: Text("Hint 2",
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Tab(
                child: Text("Hint 3",
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildHintTextContainer(0),
            _buildHintTextContainer(1),
            _buildHintTextContainer(2)
          ],
        ),
      ),
    );
  }
}
