import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/services/auth/bloc/auth_bloc.dart';
import 'package:notewise/services/auth/bloc/auth_event.dart';

import '../Route/route.dart';
import '../services/auth/auth_service.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required String title,
  required String description,
}) {
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
                    // context.read<AuthBloc>().add(const AuthEventLoggedOut());
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

Future<void> showShareErrorIfNoteEmpty(
  BuildContext context,
) async {
  await showErrorDialog(
    context,
    title: 'Sharing',
    description: 'You cannot share an empty note',
  );
}

Future<void> showCategoriesDialog(
    BuildContext context, TextEditingController categoryNameController) async {
  await showDialog(
      context: context,
      builder: ((context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: AlertDialog(
            title: const Text('Add a category'),
            content: TextField(
              controller: categoryNameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(6),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 4, 94, 211), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 4, 94, 211), width: 1),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: (() async {
                  Navigator.of(context).pop();
                }),
                child: const Text('Ok'),
              ),
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
