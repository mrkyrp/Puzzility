import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:puzzility/ThemeProvider.dart';

class GradientButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle style;
  final VoidCallback onTap;
  final LinearGradient gradient = ThemeProvider().primaryGradient();

  GradientButton(this.text, {this.icon, this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
      ),
      child: FlatButton(
        onPressed: () {
          onTap();
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: gradient, borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon != null
                    ? Icon(
                        icon,
                        color: Colors.white,
                      )
                    : SizedBox(
                        width: 0,
                        height: 0,
                      ),
                Text(
                  text,
                  textAlign: TextAlign.left,
                  style: style ?? Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
