import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/services/cloud/cloud_note.dart';
import 'package:notewise/services/cloud/firebase_cloud_note.dart';
import 'package:notewise/utilities/grid_container.dart';

import '../Route/route.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late FireBaseCloudStorage _noteService;
  final noteId = AuthService.firebase().currentUser!.id;

  var _selectedIndex = 0;

  @override
  void initState() {
    _noteService = FireBaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<CloudNote>>(
          stream: _noteService.allNotes(ownerUserId: noteId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allNotes = snapshot.data!;

                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                              height: 70,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios_new))),
                          Text(
                            'All Notes',
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: const Color.fromARGB(255, 88, 88, 88)),
                          ),
                          Expanded(child: MyGridContainer(notes: allNotes)),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }

              default:
                return const Center(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
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
      ),
    );
  }
}
