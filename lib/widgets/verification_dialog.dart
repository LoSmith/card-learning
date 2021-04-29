import 'package:flutter/material.dart';

Future<void> verifyActionWithPopUpDialog(BuildContext context, Function action, String dialogTitle, String dialogContentText) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(dialogTitle.toString()),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(dialogContentText.toString()),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              action();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}