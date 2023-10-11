import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/screens/note_list.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/services/cloud/cloud_category.dart';
import 'package:notewise/services/cloud/firebase_cloud_note.dart';
import '../services/cloud/cloud_note.dart';

class NoteToAdd extends StatefulWidget {
  const NoteToAdd({super.key});

  @override
  State<NoteToAdd> createState() => _CategoryListToAdd();
}

class _CategoryListToAdd extends State<NoteToAdd> {
  final _selectedIndex = 0;
  late final FireBaseCloudStorage _noteService;
  late final FireBaseCloudStorage _categoryService;

  final noteId = AuthService.firebase().currentUser!.id;
  CloudCategory? category;

  @override
  void initState() {
    _noteService = FireBaseCloudStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(59),
            color: const Color.fromARGB(255, 4, 94, 211),
          ),
          child: IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(newNote);
              }),
              icon: const Icon(
                Icons.post_add,
                color: Colors.white,
                size: 40,
              )),
        ),
        body: StreamBuilder<List<CloudNote>>(
            stream: _noteService.allNotes(ownerUserId: noteId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allNotes = snapshot.data!;

                    return Container(
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 70,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios_new)),
                            ),
                            Text(
                              'Notes',
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: const Color.fromARGB(255, 88, 88, 88)),
                            ),
                            const SizedBox(height: 20),
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
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: (() {
                      Navigator.of(context).pushNamed(categories);
                    }),
                    icon: const Icon(Icons.notes_outlined)),
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
