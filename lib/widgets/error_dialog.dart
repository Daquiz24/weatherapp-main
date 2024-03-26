import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String errorMessage) {
  if (!Platform.isIOS) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              color: Colors.red, // Change title text color
            ),
          ),
          content: Text(
            errorMessage,
            style: TextStyle(
              fontSize: 16.0, // Adjust content font size
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.blue, // Change button text color
                ),
              ),
            ),
          ],
        );
      },
    );
  } else {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              color: Colors.red, // Change title text color
            ),
          ),
          content: Text(
            errorMessage,
            style: TextStyle(
              fontSize: 16.0, // Adjust content font size
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.blue, // Change button text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
