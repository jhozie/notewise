import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Route/route.dart';
import '../utilities/showdialog.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  // File? _image;
  final _selectedIndex = 0;

  Future<void> _selectImages() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // _image = File(pickedFile.path);
      });
    }
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  final fullName = FirebaseAuth.instance.currentUser?.displayName == null
      ? ''
      : FirebaseAuth.instance.currentUser!.displayName!;
  final email = FirebaseAuth.instance.currentUser?.email == null
      ? ''
      : FirebaseAuth.instance.currentUser!.email!;

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
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('images/avatar.png'),
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
                    leading: Icon(Icons.person),
                    title: Text(
                      fullName,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 88, 88, 88)
                                  : const Color.fromARGB(255, 218, 216, 216)),
                    ),
                    subtitle: Text(
                      'Full Name',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 88, 88, 88)
                                  : const Color.fromARGB(255, 218, 216, 216)),
                    ),
                    trailing: IconButton(
                        onPressed: (() async {}),
                        icon: Icon(Icons.arrow_forward_ios)),
                  ),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color.fromARGB(255, 88, 88, 88)
                        : const Color.fromARGB(255, 218, 216, 216),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      email,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 88, 88, 88)
                                  : const Color.fromARGB(255, 218, 216, 216)),
                    ),
                    subtitle: Text(
                      'Email Address',
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
                          await showLogOutDialog(context,
                              title: 'Log Out',
                              description: 'Are you sure you want to log out?');
                        }),
                        icon: Icon(Icons.arrow_forward_ios)),
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
