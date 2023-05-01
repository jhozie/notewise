import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
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
  final _selectedIndex = 0;

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
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios_new))),
                    ],
                  ),
                  Center(
                    child: InkWell(
                      onTap: (() async {}),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('images/avatar-woman.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        fullName!,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                            color: const Color.fromARGB(255, 88, 88, 88)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: (() async {
                      final user = FirebaseAuth.instance.currentUser;
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child('profile_pictures')
                          .child(user!.uid + '.jpg');
                      final task = ref.putFile(_image!);
                      final url = await task.snapshot.ref.getDownloadURL();
                      final userRef = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid);
                      userRef.update({'profilePictureUrl': url});
                      final userDoc = await userRef.get();
                      final profilePictureUrl = userDoc['profilePictureUrl'];
                      _selectImages();
                    }),
                    child: Text(
                      'Full Name',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: const Color.fromARGB(255, 88, 88, 88)),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      'Personal Information',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: const Color.fromARGB(255, 88, 88, 88)),
                    ),
                    subtitle: Text(
                      'Click to access your personal information',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: const Color.fromARGB(255, 88, 88, 88)),
                    ),
                    trailing: IconButton(
                        onPressed: (() {
                          Navigator.pushNamed(context, personalInfo);
                        }),
                        icon: Icon(Icons.arrow_forward_ios)),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Log Out',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: const Color.fromARGB(255, 88, 88, 88)),
                    ),
                    subtitle: Text(
                      'Click to log out your account',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: const Color.fromARGB(255, 88, 88, 88)),
                    ),
                    trailing: IconButton(
                        onPressed: (() async {
                          await showLogOutDialog(context,
                              title: 'Log Out',
                              description: 'Are you sure you want to log out?');
                        }),
                        icon: Icon(Icons.arrow_forward_ios)),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: (() {
                    Navigator.of(context).pushNamed(note);
                  }),
                  icon: Icon(Icons.home_filled)),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: (() {
                    Navigator.of(context).pushNamed(categories);
                  }),
                  icon: Icon(Icons.notes_outlined)),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: (() {
                    Navigator.of(context).pushNamed(settings);
                  }),
                  icon: Icon(Icons.settings_outlined)),
              label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
      ),
    );
  }
}
