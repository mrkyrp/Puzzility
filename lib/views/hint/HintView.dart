import 'package:flutter/material.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/RemainingCoin.dart';
import 'package:puzzility/model/Puzzle.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HintView extends StatefulWidget {
  Puzzle puzzle;
  HintView(this.puzzle);
  @override
  _HintViewState createState() => _HintViewState();
}

class _HintViewState extends State<HintView> {
  _onTabBarTapped(int index) {}

  Widget _buildHintTextContainer(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        widget.puzzle.hints[index],
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          actions: [RemainingCoin()],
          backgroundColor: ThemeProvider().darkBlue(),
          bottom: TabBar(
            onTap: (index) {
              _onTabBarTapped(index);
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
                child: Text("Hint 1",style:Theme.of(context).textTheme.bodyText2),
              ),
              Tab(
                child: Text("Hint 2",style:Theme.of(context).textTheme.bodyText2),
              ),
              Tab(
                child: Text("Hint 3",style:Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ),
        body: TabBarView(
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
