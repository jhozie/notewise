import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/auth/auth_service.dart';
import 'package:notewise/firebase_options.dart';

import '../Route/route.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 37, 105, 207),
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 75,
                )),
            const SizedBox(height: 30),
            Text(
              'Check Your Email',
              style: GoogleFonts.nunito(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Please verify your email to continue',
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (() async {
                final snackBar = SnackBar(
                    backgroundColor: Colors.red[800],
                    content: Text('Email not yet verified'));

                final user = AuthService.firebase().currentUser;
                if (user != null) {
                  if (user.isEmailVerified) {
                    Navigator.of(context).pushNamed(RouteManager.register);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              }),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(400, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'Confirm Email',
                style: TextStyle(fontSize: 20, fontFamily: 'nunito'),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
