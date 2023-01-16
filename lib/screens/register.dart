import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'package:notewise/firebase_options.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // late final TextEditingController _fullName;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    // _fullName = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    // _fullName.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: const [
                            SizedBox(
                                height: 100,
                                child: Icon(Icons.arrow_back_ios_new)),
                          ],
                        ),
                        Text(
                          'Welcome',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: const Color.fromARGB(255, 88, 88, 88)),
                        ),
                        const SizedBox(height: 10),
                        const MyText(
                          text: 'Please sign in to continue',
                          fontsize: 20,
                        ),
                        // const SizedBox(height: 20),
                        // MyTextField(
                        //   label: 'Ful Name',
                        //   hint: 'Joe Doe',
                        //   controller: _fullName,
                        // ),
                        const SizedBox(height: 20),
                        MyTextField(
                          controller: _email,
                          label: 'Email',
                          hint: 'johndoe@gmail.com',
                        ),
                        const SizedBox(height: 20),
                        // TextField(
                        //   controller: _email,
                        // ),
                        // TextField(
                        //   controller: _password,
                        // ),
                        MyTextField(
                          controller: _password,
                          label: 'Password',
                          hint: 'Your Password',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            MyText(
                              text: 'Forgot Password',
                              fontsize: 17,
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: (() async {
                              final email = _email.text;
                              final password = _password.text.trim();

                              try {
                                final userCredentials = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'invalid-email') {
                                  print('Invalid Email');
                                } else if (e.code == 'weak-password') {
                                  print('Weak Password');
                                } else if (e.code == 'email-already-in-use') {
                                  print('Email already in use');
                                }
                              }
                            }),
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(400, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              'Sign Up',
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
            default:
              return const Text('loading');
          }
        }),
      ),
    );
  }
}
