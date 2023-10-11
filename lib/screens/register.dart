import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/utilities/exceptions.dart';
import '../main.dart';

import '../utilities/myTextfield.dart';
import '../utilities/my_text.dart';
import '../utilities/showdialog.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _fullName;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _fullName = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _fullName.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                'Welcome',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: const Color.fromARGB(255, 88, 88, 88)),
              ),
              const SizedBox(height: 10),
              const MyText(
                text: 'Please sign up to continue',
                fontsize: 20,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _fullName,
                label: 'Full Name',
                hint: 'Your Full Name',
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _email,
                label: 'Email',
                hint: 'johndoe@gmail.com',
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _password,
                label: 'Password',
                hint: 'Your Password',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: (() async {
                    final email = _email.text;
                    final password = _password.text.trim();
                    final fullName = _fullName.text.trim();
                    try {
                      await AuthService.firebase().createUser(
                          email: email, password: password, fullName: fullName);
                      await AuthService.firebase().sendEmailVerification();
                      Navigator.of(context).pushNamed(homepage);
                    } on RegisterInvalidEmailException catch (e) {
                      await showErrorDialog(context,
                          title: 'Invalid Email',
                          description:
                              'Email provided is not valid. Please check and try again');
                    } on WeakPasswordException {
                      await showErrorDialog(context,
                          title: 'Weak Password',
                          description:
                              'The password provided is weak. Please check and try again');
                    } on EmailAlreadyInUseException {
                      await showErrorDialog(context,
                          title: 'Email Already in Use',
                          description:
                              'The Email provided is already in use. Please check and try again');
                    } on GenericException {
                      await showErrorDialog(context,
                          title: 'An Error Occured',
                          description: 'Something went wrong');
                    }
                    //TODO FULL NAME EXCEPTIONS
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
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'Or Sign up with:',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 4, 94, 211)
                              .withOpacity(0.6),
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
                      Navigator.of(context).pushNamed(login);
                    }),
                    child: Text(
                      'Login',
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
