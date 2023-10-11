import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/services/auth/firebase_auth_provider.dart';
import 'package:notewise/utilities/exceptions.dart';
import 'package:notewise/utilities/showdialog.dart';

import '../main.dart';
import '../utilities/myTextfield.dart';
import '../utilities/my_text.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                  'Reset Password',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: const Color.fromARGB(255, 88, 88, 88)),
                ),
                const SizedBox(height: 10),
                const MyText(
                  text: 'Provide your email to reset your password',
                  fontsize: 20,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  label: 'Email',
                  hint: 'johndoe@gmail.com',
                  controller: _email,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: (() async {
                      final email = _email.text.trim();
                      try {
                        await FirebaseAuthProvider()
                            .resetPassword(email: email);
                        Navigator.of(context).pushNamed(passwordSent);
                      } on RegisterInvalidEmailException {
                        await showErrorDialog(context,
                            title: 'Invalid Email',
                            description: 'Email not valid');
                      }
                    }),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 37, 105, 207),
                        minimumSize: const Size(400, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      'Reset Password',
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
      ),
    );
  }
}
