import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context,
    {required String title, required String description}) {
  return showDialog(
      context: context,
      builder: ((context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }));
}
