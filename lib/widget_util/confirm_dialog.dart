import 'package:flutter/material.dart';

Future<bool> confirmDialog(BuildContext context,
    {title = 'Exit App',
    content = 'Are you sure you want to exit?',
    yesLabel = 'Yes',
    noLabel = 'No'}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(noLabel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(yesLabel),
              ),
            ],
          );
        },
      ) ??
      false;
}
