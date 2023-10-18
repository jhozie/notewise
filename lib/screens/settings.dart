import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Route/route.dart';

import '../utilities/showdialog.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({super.key});

  @override
  State<MySettingsPage> createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  File? _image;
  // final _selectedIndex = 0;

  Future<void> _selectImages() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _image;
      });
    }
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  final fullName = FirebaseAuth.instance.currentUser?.displayName == null
      ? ''
      : FirebaseAuth.instance.currentUser!.displayName!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.white,
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
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios_new))),
                    ],
                  ),
                  Center(
                    child: InkWell(
                      onTap: (() async {}),
                      child: const CircleAvatar(
                        radius: 100,
                        child: CircleAvatar(
                          radius: 95,
                          backgroundImage: AssetImage('images/avatar.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        fullName,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color.fromARGB(255, 88, 88, 88)
                                    : const Color.fromARGB(255, 218, 216, 216)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color.fromARGB(255, 88, 88, 88)
                        : const Color.fromARGB(255, 218, 216, 216),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 4, 94, 211).withOpacity(0.6),
                    ),
                    title: Text(
                      'Personal Information',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 88, 88, 88)
                                  : const Color.fromARGB(255, 218, 216, 216)),
                    ),
                    subtitle: Text(
                      'Click to access your personal information',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 88, 88, 88)
                                  : const Color.fromARGB(255, 218, 216, 216)),
                    ),
                    trailing: IconButton(
                        onPressed: (() {
                          Navigator.pushNamed(context, personalInfo);
                        }),
                        icon: Icon(Icons.arrow_forward_ios)),
                  ),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color.fromARGB(255, 88, 88, 88)
                        : const Color.fromARGB(255, 218, 216, 216),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 4, 94, 211).withOpacity(0.6),
                    ),
                    title: Text(
                      'Log Out',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 88, 88, 88)
                                  : const Color.fromARGB(255, 218, 216, 216)),
                    ),
                    subtitle: Text(
                      'Click to log out your account',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 88, 88, 88)
                                  : const Color.fromARGB(255, 218, 216, 216)),
                    ),
                    trailing: IconButton(
                        onPressed: (() async {
                          // context
                          //     .read<AuthBloc>()
                          //     .add(const AuthEventLoggedOut());
                          await showLogOutDialog(context,
                              title: 'Log Out',
                              description: 'Are you sure you want to log out?');
                        }),
                        icon: const Icon(Icons.arrow_forward_ios)),
                  ),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color.fromARGB(255, 88, 88, 88)
                        : const Color.fromARGB(255, 218, 216, 216),
                  ),
                ]),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   iconSize: 30,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //             onPressed: (() {
      //               Navigator.of(context).pushNamed(note);
      //             }),
      //             icon: Icon(Icons.home_filled)),
      //         label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //             onPressed: (() {
      //               Navigator.of(context).pushNamed(categories);
      //             }),
      //             icon: Icon(Icons.notes_outlined)),
      //         label: 'Categories'),
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //             onPressed: (() {
      //               Navigator.of(context).pushNamed(settings);
      //             }),
      //             icon: Icon(Icons.settings_outlined)),
      //         label: 'Settings'),
      //   ],
      //   currentIndex: _selectedIndex,
      // ),
    );
  }
}
