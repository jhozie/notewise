import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/services/auth/auth_service.dart';

import 'package:notewise/utilities/exceptions.dart';
import 'package:notewise/utilities/showdialog.dart';

import '../utilities/myTextfield.dart';
import '../utilities/my_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  var _obscureText = true;
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
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(
                  // children: const [
                  //   SizedBox(height: 100, child: Icon(Icons.arrow_back_ios_new)),
                  // ],
                  ),
              Text(
                'Welcome',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color.fromARGB(255, 88, 88, 88)
                        : const Color.fromARGB(255, 218, 216, 216)),
              ),
              const SizedBox(height: 10),
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
                obscureText: _obscureText,
                suffixIcon: GestureDetector(
                  onTap: (() {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  }),
                  child: _obscureText
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: (() {
                        Navigator.of(context).pushNamed(passwordReset);
                      }),
                      child: const MyText(
                        text: 'Forgot Password?',
                        fontsize: 17,
                      ))
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    // context
                    //     .read<AuthBloc>()
                    //     .add(AuthEventLogin(email, password));

                    await AuthService.firebase()
                        .logIn(email: email, password: password);
                    Navigator.of(context).pushNamed(homepage);
                  } on UserNotFoundException {
                    await showErrorDialog(context,
                        title: 'User Not Found',
                        description:
                            'this user doesn\'t is not registered. Please check and try again');
                  } on WrongPasswordException {
                    await showErrorDialog(context,
                        title: 'Incorrect Credentials',
                        description:
                            'Your credentials is incorrect. Please check and try again');
                  } on LoginInvalidEmailException {
                    await showErrorDialog(context,
                        title: 'An Error Occured',
                        description: 'Something went wrong');
                  } on GenericException {
                    await showErrorDialog(context,
                        title: 'An Error Occured',
                        description: 'Something went wrong');
                  }
                }),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontFamily: 'nunito'),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'Or Sign in with:',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: () async {
                    try {
                      await AuthService.firebase().googleSignIn();
                      Navigator.of(context).pushNamed(note);
                    } on GoogleSignInException {
                      await showErrorDialog(context,
                          title: 'Sign In Failed',
                          description: 'Please again later');
                    } on GenericException {
                      await showErrorDialog(context,
                          title: 'An Error Occured',
                          description: 'Something went wrong');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Color.fromARGB(255, 4, 94, 211).withOpacity(0.6),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(69)),
                    height: 50,
                    child: Image.asset(
                      'images/googleee.png',
                      width: 50,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account yet?',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  TextButton(
                    onPressed: (() {
                      Navigator.of(context).pushNamed(register);
                    }),
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
