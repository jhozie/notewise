import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/firebase_options.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
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
                        const Text(
                          'Welcome',
                          style: TextStyle(
                              fontFamily: 'nunito',
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: Color.fromARGB(255, 88, 88, 88)),
                        ),
                        const SizedBox(height: 20),
                        const MyText(
                          text: 'Please sign in to continue',
                          fontsize: 20,
                        ),
                        const SizedBox(height: 20),
                        MyTextField(
                          label: 'Email',
                          hint: 'johndoe@gmail.com',
                          controller: _email,
                        ),
                        const SizedBox(height: 20),
                        MyTextField(
                          label: 'Password',
                          hint: 'Your Password',
                          controller: _password,
                          obscureText: true,
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
                            final password = _password.text;
                            try {
                              final userCredential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              print(userCredential);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('user not found');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong Password');
                              } else {
                                print(e.code);
                              }
                            }
                          }),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(400, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            'Login',
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'nunito'),
                          ),
                        ),
                        TextButton(
                            onPressed: (() {
                              Navigator.of(context)
                                  .popAndPushNamed(RouteManager.homepage);
                            }),
                            child: Text('Email Verify'))
                      ],
                    ),
                  ),
                ),
              );
            default:
              return const Text('loading...');
          }
        },
      ),
    );
  }
}
