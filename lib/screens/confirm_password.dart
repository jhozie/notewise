import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/utilities/exceptions.dart';
import 'package:notewise/utilities/showdialog.dart';

import '../utilities/myTextfield.dart';
import '../utilities/my_text.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  late final TextEditingController _email;
  late final TextEditingController _oldPassword;
  late final TextEditingController _newPassword;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _oldPassword.dispose();
    _newPassword.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: const [
                  SizedBox(height: 100, child: Icon(Icons.arrow_back_ios_new)),
                ],
              ),
              Text(
                'Create new password',
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
                hint: 'your email address',
                controller: _email,
              ),
              const SizedBox(height: 20),
              MyTextField(
                label: 'Old Password',
                hint: 'your old password',
                controller: _oldPassword,
              ),
              const SizedBox(height: 20),
              MyTextField(
                label: 'New Password',
                hint: 'your new password',
                controller: _newPassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: (() async {
                    final email = _email.text.trim();
                    final oldPassword = _oldPassword.text.trim();
                    final newPassword = _newPassword.text.trim();
                    try {
                      await AuthService.firebase().updatePassword(
                          email: email,
                          oldPassword: oldPassword,
                          newPassword: newPassword);
                    } on WrongPasswordException {
                      await showErrorDialog(context,
                          title: 'Incorrect Credentials',
                          description:
                              'Your credentials is incorrect. Please check and try again');
                    } on WeakPasswordException {
                      await showErrorDialog(context,
                          title: 'Weak Password',
                          description:
                              'Your password is weak. Please check and try again');
                    } on LoginInvalidEmailException {
                      await showErrorDialog(context,
                          title: 'Invalid Email',
                          description:
                              'Email is invalid. Pls input the right email');
                    }
                  }),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 37, 105, 207),
                      minimumSize: const Size(400, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Change Password',
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
