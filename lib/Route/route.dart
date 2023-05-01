// import 'package:flutter/material.dart';
// import 'package:notewise/main.dart';
// import 'package:notewise/screens/categories.dart';
// import 'package:notewise/screens/email_verify.dart';
// import 'package:notewise/screens/login.dart';
// import 'package:notewise/screens/new_note.dart';
// import 'package:notewise/screens/note.dart';
// import 'package:notewise/screens/onboarding.dart';
// import 'package:notewise/screens/register.dart';

// class RouteManager {
//   static const homepage = '/';
//   static const String register = '/register';
//   static const String login = '/login';
//   static const String onBoarding = '/onboarding';
//   static const String emailVerify = '/email-verify';
//   static const String note = '/note';
//   static const String newNote = '/new-note';
//   static const String categories = '/categories';

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case register:
//         return MaterialPageRoute(builder: ((context) => const Register()));
//       case login:
//         return MaterialPageRoute(builder: ((context) => const Login()));
//       case onBoarding:
//         return MaterialPageRoute(builder: ((context) => const Onboarding()));
//       case homepage:
//         return MaterialPageRoute(builder: ((context) => const MyHomePage()));
//       case emailVerify:
//         return MaterialPageRoute(builder: ((context) => const EmailVerify()));
//       case note:
//         return MaterialPageRoute(builder: ((context) => const NoteScreen()));
//       case newNote:
//         return MaterialPageRoute(
//             builder: ((context) => const CreateUpdateNote()));
//       case categories:
//         return MaterialPageRoute(builder: ((context) => const Categories()));
//       default:
//         throw Exception('Route not found');
//     }
//   }
// }

const homepage = '/';
const String register = '/register';
const String login = '/login';
const String onBoarding = '/onboarding';
const String emailVerify = '/email-verify';
const String note = '/note';
const String newNote = '/new-note';
const String categories = '/categories';
const String settings = '/settings';
const String personalInfo = '/personal-info';
const String passwordReset = '/password-reset/';
const String passwordSent = '/password-sent';
