import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puzzility/ThemeProvider.dart';

class ButtonWithBorder extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Function onTap;

  ButtonWithBorder(this.text, {this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 4.0, color: ThemeProvider().blueBorder()),
          color: Colors.transparent,
        ),
        child: FlatButton(
            onPressed: onTap,
            child: Text(text, style: Theme.of(context).textTheme.headline2)));
  }
}
