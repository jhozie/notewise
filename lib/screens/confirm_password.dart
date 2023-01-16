import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  late final TextEditingController _oldPassword;
  late final TextEditingController _newPassword;

  @override
  void initState() {
    super.initState();
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _oldPassword.dispose();
    _newPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
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
                  onPressed: (() {}),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 37, 105, 207),
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
  }
}
