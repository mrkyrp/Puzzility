import 'package:flutter/material.dart';
import 'package:puzzility/ThemeProvider.dart';

class RemainingCoin extends StatelessWidget {
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
        Text("200" + " +", style: Theme.of(context).textTheme.headline2),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
