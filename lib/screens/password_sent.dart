import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';

import '../main.dart';
import '../utilities/my_text.dart';

class PasswordSent extends StatefulWidget {
  const PasswordSent({super.key});

  @override
  State<PasswordSent> createState() => _PasswordSentState();
}

class _PasswordSentState extends State<PasswordSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    child: IconButton(
                      onPressed: (() {
                        Navigator.of(context).pop();
                      }),
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                ],
              ),
              Text(
                'Check Your Email',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: const Color.fromARGB(255, 88, 88, 88)),
              ),
              const SizedBox(height: 10),
              const MyText(
                text:
                    'An email has been sent to your inbox for password reset. Once your password is set, click the login button to access your account',
                fontsize: 20,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: (() async {
                    Navigator.of(context).pushNamed(login);
                  }),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 37, 105, 207),
                      minimumSize: const Size(400, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Login',
                    style: GoogleFonts.nunito(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
