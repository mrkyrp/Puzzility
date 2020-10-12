import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogController {
  BuildContext context;
  AlertDialogController(this.context);
  showAlertDialog(
      {String title = "",
      String message = "",
      cancelActionTitle = "",
      okActionTitle = "",
      VoidCallback onCancelPressed,
      VoidCallback onOkPressed}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: title != "" ? Text(title) : null,
                content: message != "" ? Text(message) : null,
                actions: <Widget>[
                  cancelActionTitle != ""
                      ? CupertinoDialogAction(
                          child: Text(cancelActionTitle),
                          onPressed: onCancelPressed != null
                              ? onCancelPressed
                              : () {
                                  Navigator.of(context).pop();
                                },
                        )
                      : Container(),
                  CupertinoDialogAction(
                    child: Text(okActionTitle),
                    onPressed: onOkPressed != null
                        ? onOkPressed
                        : () {
                            Navigator.of(context).pop();
                          },
                  ),
                ],
              )
            : AlertDialog(
                title: title != "" ? Text(title) : null,
                content: SingleChildScrollView(
                  child: message != "" ? Text(message) : null,
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(cancelActionTitle),
                    onPressed: onCancelPressed != null
                        ? onCancelPressed
                        : () {
                            Navigator.of(context).pop();
                          },
                  ),
                  TextButton(
                    child: Text(okActionTitle),
                    onPressed: onOkPressed != null
                        ? onOkPressed
                        : () {
                            Navigator.of(context).pop();
                          },
                  ),
                ],
              );
      },
    );
  }
}
