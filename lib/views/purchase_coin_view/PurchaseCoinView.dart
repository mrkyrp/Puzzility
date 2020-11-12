import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/RemainingCoin.dart';
import 'package:puzzility/service/PlayerRepository.dart';
import 'package:puzzility/views/puzzle_list/PuzzleListView.dart';

class PurchaseCoinView extends StatelessWidget {
  _onBackPressed(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => PuzzleListView(),
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
        title: Text("SHOP"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            _onBackPressed(context);
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
        ),
      ),
    );
  }
}
