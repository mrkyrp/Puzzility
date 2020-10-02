import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/components/GradientButton.dart';
import 'package:puzzility/model/Puzzle.dart';

class PuzzleCell extends StatelessWidget {
  final Puzzle puzzle;
  final VoidCallback onTap;
  final int stars;
  final bool isUnlocked;

  PuzzleCell(this.puzzle,
      {this.onTap, this.stars = 0, this.isUnlocked = false});

  Widget _leadingContainer() {
    return Flexible(
      flex: 1,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            color: ThemeProvider().gold(),
          ),
          child: LayoutBuilder(builder: (context, constraint) {
            return Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: constraint.biggest.width - 10,
              ),
            );
          })),
    );
  }

  Widget _trailingContainer(BuildContext context) {
    return Flexible(
      flex: 4,
      child: Container(
        padding:
            const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 4.0, left: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
              child: AutoSizeText(
                puzzle.puzzleNo.toString() + ": " + puzzle.title,
                style: Theme.of(context).textTheme.headline2,
                maxLines: 2,
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  RatingBar(
                    initialRating: stars.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 3,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: ThemeProvider().gold(),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: GradientButton(
                      null,
                      "Play",
                      onTap: onTap,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ThemeProvider().lightBlue(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[_leadingContainer(), _trailingContainer(context)],
      ),
    );
  }
}
