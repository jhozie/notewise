import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/firebase_options.dart';
import 'package:notewise/screens/email_verify.dart';
import 'package:notewise/screens/login.dart';
import 'package:notewise/screens/note.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 37, 105, 207)))),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.note,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
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
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
