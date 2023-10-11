// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:notewise/Route/route.dart';
// import 'package:notewise/screens/note_list.dart';
// import 'package:notewise/services/auth/auth_service.dart';
// import 'package:notewise/services/cloud/firebase_cloud_note.dart';
// import '../services/cloud/cloud_note.dart';
// import '../utilities/container_note.dart';
// import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

// class NoteScreen extends StatefulWidget {
//   const NoteScreen({super.key});

//   @override
//   State<NoteScreen> createState() => _NoteScreenState();
// }

// class _NoteScreenState extends State<NoteScreen> {
//   final _selectedIndex = 0;
//   late final FireBaseCloudStorage _noteService;
//   final noteId = AuthService.firebase().currentUser!.id;
//   List<CloudNote> newNotes = [];

//   List<CloudNote> _searchedNotes = [];

//   // CloudNote? _note;
//   @override
//   void initState() {
//     _noteService = FireBaseCloudStorage();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         floatingActionButton: Container(
//           height: 80,
//           width: 80,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(59),
//             color: const Color.fromARGB(255, 4, 94, 211),
//           ),
//           child: IconButton(
//               onPressed: (() {
//                 Navigator.of(context).pushNamed(newNote);
//               }),
//               icon: const Icon(
//                 Icons.post_add,
//                 color: Colors.white,
//                 size: 40,
//               )),
//         ),
//         body: StreamBuilder<List<CloudNote>>(
//             stream: _noteService.allNotes(ownerUserId: noteId),
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                 case ConnectionState.active:
//                   if (snapshot.hasData) {
//                     final _allNotes = snapshot.data!;
//                     _searchedNotes = List.from(_allNotes);
//                     String searchQuery = '';

//                     searchNotes() {
//                       setState(() {
//                         _searchedNotes = _allNotes
//                             .where((note) => (note.title.toLowerCase())
//                                 .contains(searchQuery.toLowerCase()))
//                             .toList();
//                       });
//                     }

//                     final pinnedNote = _searchedNotes
//                         .where((notes) => notes.isPinned)
//                         .toList();

//                     return Container(
//                       color: Color.fromARGB(255, 255, 255, 255),
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 50),
//                             // Circle Avatar Section
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10),
//                                     child: Text(
//                                       'Notes',
//                                       style: GoogleFonts.nunito(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 30,
//                                           color: const Color.fromARGB(
//                                               255, 88, 88, 88)),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 10),
//                                     child: CircleAvatar(
//                                       radius: 20,
//                                       child: InkWell(
//                                         onTap: (() {
//                                           Navigator.of(context)
//                                               .pushNamed(settings);
//                                         }),
//                                         child: const CircleAvatar(
//                                           radius: 17,
//                                           backgroundImage: AssetImage(
//                                               'images/avatar-woman.jpg'),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ]),
//                             const SizedBox(height: 20),
//                             // Search Field
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 10, right: 10),
//                               child: TextField(
//                                 onChanged: (value) {
//                                   setState(() {
//                                     searchQuery = value;
//                                   });

//                                   searchNotes();
//                                 },
//                                 decoration: InputDecoration(
//                                   prefixIcon: const Icon(Icons.search),
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 3, horizontal: 20),
//                                   hintText: 'hint',
//                                   border: const OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: Color.fromARGB(255, 4, 94, 211),
//                                         width: 2),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(30)),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: const Color.fromARGB(
//                                                 255, 4, 94, 211)
//                                             .withOpacity(0.2),
//                                         width: 2),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(30)),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Section for Pinned Notes

//                             pinnedNote.isEmpty
//                                 ? const SizedBox.shrink()
//                                 : SizedBox(
//                                     height: 180,
//                                     child: MyNoteContainer(notes: pinnedNote)),

//                             Expanded(
//                               child: Container(
//                                   height: MediaQuery.of(context).size.height,
//                                   child: ContainedTabBarView(
//                                       tabBarProperties: const TabBarProperties(
//                                         labelColor: Colors.black,
//                                         unselectedLabelColor:
//                                             Color.fromARGB(255, 139, 139, 139),
//                                         indicatorWeight: 4.0,
//                                         indicatorSize:
//                                             TabBarIndicatorSize.label,
//                                       ),
//                                       tabs: [
//                                         Text(
//                                           'Recent Notes',
//                                           style: GoogleFonts.nunito(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 17,
//                                             // color:
//                                             //     Color.fromARGB(255, 2, 2, 2)
//                                           ),
//                                         ),
//                                         Text('Favorites',
//                                             style: GoogleFonts.nunito(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 17,
//                                               // color: const Color.fromARGB(
//                                               //     255, 88, 88, 88)),
//                                             ))
//                                       ],
//                                       views: [
//                                         SingleChildScrollView(
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 10, right: 10),
//                                             child: Column(
//                                               children: [
//                                                 _searchedNotes.isEmpty
//                                                     ? Center(
//                                                         child: Text(
//                                                           'No Recent Notes',
//                                                           style: GoogleFonts
//                                                               .nunito(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontSize: 20,
//                                                           ),
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                         ),
//                                                       )
//                                                     : NoteListView(
//                                                         notes: _searchedNotes,
//                                                         onTap: (note) async {
//                                                           await Navigator.of(
//                                                                   context)
//                                                               .pushNamed(
//                                                                   newNote,
//                                                                   arguments:
//                                                                       note);
//                                                         },
//                                                         // listCount: _searchedNotes.length,
//                                                       ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 10, right: 10),
//                                           child: NoteListView(
//                                             notes: pinnedNote,
//                                             onTap: (note) async {
//                                               await Navigator.of(context)
//                                                   .pushNamed(newNote,
//                                                       arguments: note);
//                                             },
//                                           ),
//                                         )
//                                       ])),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   } else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 default:
//                   return const Center(child: CircularProgressIndicator());
//               }
//             }),
//         // bottomNavigationBar: BottomNavigationBar(
//         //   iconSize: 30,
//         //   items: <BottomNavigationBarItem>[
//         //     const BottomNavigationBarItem(
//         //         icon: Icon(Icons.home_outlined), label: 'Home'),
//         //     BottomNavigationBarItem(
//         //         icon: IconButton(
//         //             onPressed: (() {
//         //               Navigator.of(context).pushNamed(categories);
//         //             }),
//         //             icon: const Icon(Icons.notes_outlined)),
//         //         label: 'Categories'),
//         //     BottomNavigationBarItem(
//         //         icon: IconButton(
//         //             onPressed: (() {
//         //               Navigator.of(context).pushNamed(settings);
//         //             }),
//         //             icon: Icon(Icons.settings_outlined)),
//         //         label: 'Settings'),
//         //   ],
//         //   currentIndex: _selectedIndex,
//         // ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/screens/note_list.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/services/cloud/firebase_cloud_note.dart';
import '../services/cloud/cloud_note.dart';
import '../utilities/container_note.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late final FireBaseCloudStorage _noteService;
  final noteId = AuthService.firebase().currentUser!.id;
  late final TextEditingController _searchController;
  late Timer _debounce; // Remove the nullable type

  List<CloudNote> _allNotes = [];
  List<CloudNote> _searchedNotes = [];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _noteService = FireBaseCloudStorage();

    _searchController = TextEditingController();
    _debounce = Timer(Duration.zero, () {});
  }

  // void _onSearchChanged(String value) {
  //   setState(() {
  //     searchQuery = value;
  //     _searchFuture = _performSearch();
  //   });
  // }

  // Future<void> _performSearch() async {
  //   // Simulate a network call or any asynchronous operation
  //   await Future.delayed(Duration(minutes: 1));

  //   // Filter notes based on searchQuery here
  //   filterNotes();
  // }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  void filterNotes() {
    if (searchQuery.isEmpty) {
      _searchedNotes =
          List.from(_allNotes); // Show all notes when search query is empty
    } else {
      _searchedNotes = _allNotes
          .where((note) =>
              note.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
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
            onPressed: () {
              Navigator.of(context).pushNamed(newNote);
            },
            icon: const Icon(
              Icons.post_add,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        body: StreamBuilder<List<CloudNote>>(
          stream: _noteService.allNotes(ownerUserId: noteId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            _allNotes = snapshot.data!;
            filterNotes();

            final pinnedNote =
                _searchedNotes.where((notes) => notes.isPinned).toList();

            return Container(
              color: Color.fromARGB(255, 255, 255, 255),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    // Circle Avatar Section
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Notes',
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: const Color.fromARGB(255, 88, 88, 88)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              radius: 20,
                              child: InkWell(
                                onTap: (() {
                                  Navigator.of(context).pushNamed(settings);
                                }),
                                child: const CircleAvatar(
                                  radius: 17,
                                  backgroundImage:
                                      AssetImage('images/avatar.png'),
                                ),
                              ),
                            ),
                          )
                        ]),
                    const SizedBox(height: 20),
                    // Search Field
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          if (_debounce.isActive) _debounce.cancel();
                          _debounce = Timer(Duration(milliseconds: 500), () {
                            setState(() {
                              searchQuery = value;
                              filterNotes();
                            });
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 20),
                          hintText: 'e.g my first note',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 4, 94, 211),
                                width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 4, 94, 211)
                                    .withOpacity(0.2),
                                width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    // Section for Pinned Notes

                    pinnedNote.isEmpty
                        ? const SizedBox.shrink()
                        : SizedBox(
                            height: 180,
                            child: MyNoteContainer(notes: pinnedNote)),

                    Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: ContainedTabBarView(
                              tabBarProperties: const TabBarProperties(
                                labelColor: Colors.black,
                                unselectedLabelColor:
                                    Color.fromARGB(255, 139, 139, 139),
                                indicatorWeight: 4.0,
                                indicatorSize: TabBarIndicatorSize.label,
                              ),
                              tabs: [
                                Text(
                                  'Recent Notes',
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    // color:
                                    //     Color.fromARGB(255, 2, 2, 2)
                                  ),
                                ),
                                Text('Favorites',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      // color: const Color.fromARGB(
                                      //     255, 88, 88, 88)),
                                    ))
                              ],
                              views: [
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      children: [
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
                                        // : noteListView(
                                        //     notes: _searchedNotes,
                                        //     onTap: ((note) {}))
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: NoteListView(
                                    notes: pinnedNote,
                                    onTap: (note) async {
                                      await Navigator.of(context)
                                          .pushNamed(newNote, arguments: note);
                                    },
                                  ),
                                  // child: noteListView(
                                  //     notes: pinnedNote, onTap: ((note) {})),
                                )
                              ])),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // rest of your code
      ),
    );
  }
}
