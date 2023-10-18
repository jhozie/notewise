import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/screens/new_note.dart';
import 'package:notewise/screens/password_sent.dart';
import 'package:notewise/screens/personal_info.dart';
import 'package:notewise/screens/register.dart';
import 'package:notewise/screens/reset_password.dart';
import 'package:notewise/screens/settings.dart';
import 'package:notewise/screens/login.dart';
import 'package:notewise/screens/note.dart';
import 'package:notewise/services/auth/bloc/auth_bloc.dart';
import 'package:notewise/services/auth/bloc/auth_event.dart';
import 'package:notewise/services/auth/bloc/auth_state.dart';
import 'package:notewise/services/auth/firebase_auth_provider.dart';
import 'package:notewise/utilities/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: ((context) => ThemeProvider()),
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              theme: value.themeType == ThemeType.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              // theme: ThemeData(
              //     elevatedButtonTheme: ElevatedButtonThemeData(
              //         style: ElevatedButton.styleFrom(
              //             backgroundColor: const Color.fromARGB(255, 37, 105, 207)))),
              debugShowCheckedModeBanner: false,
              home: BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(FirebaseAuthProvider()),
                child: const MyHomePage(),
              ),
              // initialRoute: note,
              // onGenerateRoute: RouteManager.generateRoute,
              routes: {
                newNote: (context) => const CreateUpdateNote(),
                login: (context) => const Login(),
                register: (context) => const Register(),
                note: (context) => const NoteScreen(),
                settings: (context) => const MySettingsPage(),
                personalInfo: (context) => const PersonalInfoPage(),
                passwordReset: (context) => const PasswordReset(),
                passwordSent: (context) => const PasswordSent(),
              },
            );
          },
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(builder: ((context, state) {
      if (state is AuthLoginState) {
        return const NoteScreen();
      } else if (state is AuthStateEmailLogin) {
        return const NoteScreen();
      } else if (state is AuthStateNeedsVerification) {
        return const NoteScreen();
      } else if (state is AuthLogoutState) {
        return const Login();
      } else {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
    }));
    // return FutureBuilder(
    //   future: AuthService.firebase().initialize(),
    //   builder: ((context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         final user = AuthService.firebase().currentUser;
    //         if (user != null) {
    //           if (user.isEmailVerified) {
    //             return const NoteScreen();
    //           } else {
    //             return const EmailVerify();
    //           }
    //         } else {
    //           return const Login();
    //         }

    //       default:
    //         return const Center(child: CircularProgressIndicator());
    //     }
    //   }),
    // );
  }
}
