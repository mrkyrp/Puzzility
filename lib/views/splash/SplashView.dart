import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/views/puzzle_list/PuzzleListView.dart';

class SplashView extends StatelessWidget {
  static const Duration timeout = Duration(seconds: 2);

  startTimer(BuildContext context) {
    Timer(
        timeout,
        () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => PuzzleListView(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              )
            });
  }

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return Scaffold(
      backgroundColor: ThemeProvider().darkBlue(),
    );
  }
}
