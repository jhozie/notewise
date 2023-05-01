import 'package:flutter/material.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/services/auth/auth_service.dart';

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

Future<void> showLogOutDialog(BuildContext context,
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
                  onPressed: (() async {
                    await AuthService.firebase().logOut();

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(login, (route) => false);
                  }),
                  child: const Text('Ok')),
              TextButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  child: const Text('Cancel'))
            ],
          ),
        );
      }));
}

Future<void> showShareErrorIfNoteEmpty(BuildContext context) async {
  await showErrorDialog(
    context,
    title: 'Sharing',
    description: 'You cannot share an empty note',
  );
}
