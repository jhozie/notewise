import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/screens/note_list.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/services/cloud/firebase_cloud_note.dart';
import 'package:notewise/utilities/showdialog.dart';

import '../services/cloud/cloud_note.dart';
import '../utilities/container_note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _selectedIndex = 0;
  late final FireBaseCloudStorage _noteService;
  final noteId = AuthService.firebase().currentUser!.id;
  // List<CloudNote> _allNotes = [];
  List<CloudNote> _searchedNotes = [];
  CloudNote? _note;
  @override
  void initState() {
    _noteService = FireBaseCloudStorage();

    super.initState();
  }

  searchNotes(String search) async {
    final _allNotes = await _noteService.allNotes(ownerUserId: noteId).first;

    setState(() {
      _searchedNotes = _allNotes
          .where((note) =>
              (note.title.toLowerCase()).contains(search.toLowerCase()))
          .toList();
    });
  }
  // void searchNotes(String search) {
  //   setState(() {
  //     _searchedNotes = _allNotes
  //         .where(
  //             (note) => note.title.toLowerCase().contains(search.toLowerCase()))
  //         .toList();
  //   });
  // }

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
                    final _allNotes = snapshot.data!;

                    _searchedNotes = List.from(_allNotes);

                    final pinnedNote = _searchedNotes
                        .where((notes) => notes.isPinned)
                        .toList();

                    // List<CloudNote> searchedNote = List.from(allNotes);
                    // void searchedNotes(String search) {
                    //   setState(() {
                    //     searchedNote = allNotes
                    //         .where((note) => note.text
                    //             .toLowerCase()
                    //             .contains(search.toLowerCase()))
                    //         .toList();
                    //   });
                    // }

                    return SingleChildScrollView(
                      child: Container(
                        color: Color.fromARGB(255, 250, 250, 250),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 50),
                              // Circle Avatar Section
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Notes',
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: const Color.fromARGB(
                                              255, 88, 88, 88)),
                                    ),
                                    CircleAvatar(
                                      radius: 20,
                                      child: InkWell(
                                        onTap: (() async {
                                          await showLogOutDialog(context,
                                              title: 'Log Out',
                                              description:
                                                  'Are you sure you want to log out?');
                                        }),
                                        child: const CircleAvatar(
                                          radius: 17,
                                          backgroundImage: AssetImage(
                                              'images/avatar-woman.jpg'),
                                        ),
                                      ),
                                    )
                                  ]),
                              const SizedBox(height: 20),
                              // Search Field
                              TextField(
                                onChanged: (value) => searchNotes(value),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 20),
                                  hintText: 'hint',
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 4, 94, 211),
                                        width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                                255, 4, 94, 211)
                                            .withOpacity(0.2),
                                        width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                  ),
                                ),
                              ),
                              // Section for Pinned Notes

                              pinnedNote.isEmpty
                                  ? const SizedBox.shrink()
                                  : SizedBox(
                                      height: 180,
                                      child:
                                          MyNoteContainer(notes: pinnedNote)),
                              //contains tabview menu
                              // Container(
                              //   constraints:
                              //       const BoxConstraints.expand(height: 60),
                              //   child:
                              // ),
                              //Contains the Tabview Content
                              Container(
                                height: pinnedNote.isEmpty ? 450 : 340,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          'Recent Notes',
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: const Color.fromARGB(
                                                  255, 88, 88, 88)),
                                        ),
                                      ),
                                      _searchedNotes.isEmpty
                                          ? Center(
                                              child: Text(
                                                'No Recent Notes',
                                                style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : NoteListView(
                                              notes: _searchedNotes,
                                              onTap: (note) async {
                                                await Navigator.of(context)
                                                    .pushNamed(newNote,
                                                        arguments: note);
                                              },
                                              // listCount: _searchedNotes.length,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
