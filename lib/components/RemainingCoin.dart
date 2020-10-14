import 'package:flutter/material.dart';
import 'package:puzzility/ThemeProvider.dart';

class RemainingCoin extends StatelessWidget {
  int coins = 0;
  RemainingCoin(this.coins);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.monetization_on,
          color: ThemeProvider().gold(),
        ),
        SizedBox(
          width: 4,
        ),
        Text(coins.toString() + " +",
            style: Theme.of(context).textTheme.headline2),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
