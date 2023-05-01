import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/screens/allNotes.dart';
import 'package:notewise/screens/confirm_password.dart';
import 'package:notewise/screens/new_note.dart';
import 'package:notewise/screens/password_sent.dart';
import 'package:notewise/screens/personal_info.dart';
import 'package:notewise/screens/register.dart';
import 'package:notewise/screens/reset_password.dart';
import 'package:notewise/screens/settings.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/screens/email_verify.dart';
import 'package:notewise/screens/login.dart';
import 'package:notewise/screens/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 37, 105, 207)))),
      debugShowCheckedModeBanner: false,
      // initialRoute: note,
      // onGenerateRoute: RouteManager.generateRoute,
      routes: {
        homepage: (context) => const MyHomePage(),
        newNote: (context) => const CreateUpdateNote(),
        login: (context) => const Login(),
        register: (context) => const Register(),
        note: (context) => const NoteScreen(),
        categories: (context) => const Categories(),
        settings: (context) => const MySettingsPage(),
        personalInfo: (context) => const PersonalInfoPage(),
        passwordReset: (context) => const PasswordReset(),
        passwordSent: (context) => const PasswordSent(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
              } else {
                return const EmailVerify();
              }
            } else {
              return const Login();
            }

            return const NoteScreen();
          default:
            return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}

class MyText extends StatelessWidget {
  const MyText({
    required this.text,
    required this.fontsize,
    Key? key,
  }) : super(key: key);

  final String text;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
          fontSize: fontsize, color: const Color.fromARGB(255, 88, 88, 88)),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.keyboard,
    Key? key,
  }) : super(key: key);
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboard,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 4, 94, 211), width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Color.fromARGB(255, 4, 94, 211).withOpacity(0.2),
              width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
