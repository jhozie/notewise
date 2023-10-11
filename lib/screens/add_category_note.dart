// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:notewise/Route/route.dart';
// import 'package:notewise/screens/note_list.dart';
// import 'package:notewise/services/auth/auth_service.dart';
// import 'package:notewise/services/cloud/cloud_category.dart';
// import 'package:notewise/services/cloud/firebase_cloud_note.dart';
// import 'package:notewise/utilities/container_note.dart';
// import '../services/cloud/cloud_note.dart';

// class AddCategoryNote extends StatefulWidget {
//   const AddCategoryNote({super.key});

//   @override
//   State<AddCategoryNote> createState() => _AddCategoryNote();
// }

// class _AddCategoryNote extends State<AddCategoryNote> {
//   final _selectedIndex = 0;
//   late final FireBaseCloudStorage _categoryNoteService;
//   final noteId = AuthService.firebase().currentUser!.id;
//   List<CloudNote> allNotes = [];
//   List<CloudCategory> categoryNote = [];

//   // CloudNote? _note;
//   @override
//   void initState() {
//     _categoryNoteService = FireBaseCloudStorage();

//     super.initState();
//   }

//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         key: scaffoldKey,
//         floatingActionButton: Container(
//           height: 80,
//           width: 80,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(59),
//             color: const Color.fromARGB(255, 4, 94, 211),
//           ),
//           child: IconButton(
//               onPressed: (() {
//                 // Navigator.of(context).pushNamed(noteToAdd);
//                 scaffoldKey.currentState?.showBottomSheet((context) {
//                   return Container(
//                     height: 500,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20)),
//                       color: Colors.blueAccent,
//                     ),
//                     child: Container(),
//                   );
//                 });
//               }),
//               icon: const Icon(
//                 Icons.post_add,
//                 color: Colors.white,
//                 size: 40,
//               )),
//         ),
//         body: Column(
//           children: [
//             // Fetch existing notes
//             StreamBuilder<List<CloudNote>>(
//               stream: _categoryNoteService.allNotes(ownerUserId: noteId),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 allNotes = snapshot.data!;
//                 // Process and display existing notes here
//                 // You can use snapshot.data.docs to access note documents
//                 // and build your UI accordingly.

//                 return Container(
//                   child: NoteListView(notes: allNotes, onTap: ((note) {})),
//                 );
//               },
//             ),

//             // Fetch existing categories
//             StreamBuilder<List<CloudCategory>>(
//               stream: _categoryNoteService.allCategories(ownerUserId: noteId),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 categoryNote = snapshot.data!;

//                 // Process and display existing categories here
//                 // You can use snapshot.data.docs to access category documents
//                 // and build your UI accordingly.

//                 return Expanded(
//                   child: ListView.builder(
//                       itemCount: categoryNote.length,
//                       itemBuilder: ((context, index) {
//                         final category = categoryNote[index];
//                         final notToMove = allNotes[index];
//                         setState(() {});

//                         categoryNote[index].notes.add(notToMove);
//                         return Container(
//                             margin: const EdgeInsets.only(right: 10),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: const Color.fromARGB(255, 4, 94, 211)
//                                     .withOpacity(0.2)),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Center(
//                                   child: Text(
//                                     category.id,
//                                     maxLines: 2,
//                                     style: GoogleFonts.nunito(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     IconButton(
//                                         onPressed: (() {}),
//                                         icon: Icon(Icons.delete))
//                                   ],
//                                 )
//                               ],
//                             ));
//                       })),
//                 );
//               },
//             ),
//           ],
//         ),
//         // body: StreamBuilder<List<CloudNote>>(
//         //     stream: _categoryNoteService.allNotes(ownerUserId: noteId),
//         //     builder: (context, snapshot) {
//         //       switch (snapshot.connectionState) {
//         //         case ConnectionState.waiting:
//         //         case ConnectionState.active:
//         //           if (snapshot.hasData) {
//         //             final _allNotes = snapshot.data!;

//         //             return Container(
//         //               color: const Color.fromARGB(255, 255, 255, 255),
//         //               child: Padding(
//         //                 padding: const EdgeInsets.symmetric(horizontal: 10),
//         //                 child: Column(
//         //                   mainAxisAlignment: MainAxisAlignment.start,
//         //                   mainAxisSize: MainAxisSize.max,
//         //                   crossAxisAlignment: CrossAxisAlignment.start,
//         //                   children: [
//         //                     SizedBox(
//         //                       height: 70,
//         //                       child: IconButton(
//         //                           onPressed: () {
//         //                             Navigator.of(context).pop();
//         //                           },
//         //                           icon: const Icon(Icons.arrow_back_ios_new)),
//         //                     ),
//         //                     Text(
//         //                       'Notes',
//         //                       style: GoogleFonts.nunito(
//         //                           fontWeight: FontWeight.bold,
//         //                           fontSize: 30,
//         //                           color: const Color.fromARGB(255, 88, 88, 88)),
//         //                     ),
//         //                     const SizedBox(height: 20),
//         //                     Expanded(
//         //                       child: SizedBox(
//         //                         height: MediaQuery.of(context).size.height,
//         //                         child: SingleChildScrollView(
//         //                           padding: EdgeInsets.only(left: 10, right: 10),
//         //                           child: Column(
//         //                             crossAxisAlignment:
//         //                                 CrossAxisAlignment.start,
//         //                             children: [
//         //                               Padding(
//         //                                 padding: EdgeInsets.only(top: 20),
//         //                                 child: NoteListView(
//         //                                   notes: _allNotes,
//         //                                   onTap: (note) async {
//         //                                     await Navigator.of(context)
//         //                                         .pushNamed(newNote,
//         //                                             arguments: note);
//         //                                   },
//         //                                   // listCount: _searchedNotes.length,
//         //                                 ),
//         //                               )
//         //                             ],
//         //                           ),
//         //                         ),
//         //                       ),
//         //                     ),
//         //                   ],
//         //                 ),
//         //               ),
//         //             );
//         //           } else {
//         //             return const Center(child: CircularProgressIndicator());
//         //           }
//         //         default:
//         //           return const Center(child: CircularProgressIndicator());
//         //       }
//         //     }),
//         bottomNavigationBar: BottomNavigationBar(
//           iconSize: 30,
//           items: <BottomNavigationBarItem>[
//             const BottomNavigationBarItem(
//                 icon: Icon(Icons.home_outlined), label: 'Home'),
//             BottomNavigationBarItem(
//                 icon: IconButton(
//                     onPressed: (() {
//                       Navigator.of(context).pushNamed(categories);
//                     }),
//                     icon: const Icon(Icons.notes_outlined)),
//                 label: 'Categories'),
//             BottomNavigationBarItem(
//                 icon: IconButton(
//                     onPressed: (() {
//                       Navigator.of(context).pushNamed(settings);
//                     }),
//                     icon: Icon(Icons.settings_outlined)),
//                 label: 'Settings'),
//           ],
//           currentIndex: _selectedIndex,
//         ),
//       ),
//     );
//   }
// }

// class BottonSheetNoteList extends StatefulWidget {
//   const BottonSheetNoteList({Key? key}) : super(key: key);

//   @override
//   State<BottonSheetNoteList> createState() => _BottonSheetNoteListState();
// }

// class _BottonSheetNoteListState extends State<BottonSheetNoteList> {
//   final _noteService = FireBaseCloudStorage();
//   final noteId = AuthService.firebase().currentUser!.id;

//   List<CloudNote> allNotes = [];
//   List<CloudCategory> categoryNote = [];

//   void moveNote(int index) async {
//     if (index >= 0 && index < allNotes.length) {
//       final noteToMove = allNotes[index];
//       // Add the note to the destination list
//       categoryNote[index].notes.add(noteToMove);
//       // Update Firestore here if needed

//       // Call setState to rebuild the widget
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Fetch existing notes
//         StreamBuilder<List<CloudNote>>(
//           stream: _noteService.allNotes(ownerUserId: noteId),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             }
//             allNotes = snapshot.data!;
//             // Process and display existing notes here
//             // You can use snapshot.data.docs to access note documents
//             // and build your UI accordingly.

//             return Container(
//               child: NoteListView(
//                   notes: allNotes,
//                   onTap: ((note) {})), // Pass moveNote as onTap callback
//             );
//           },
//         ),

//         // Fetch existing categories
//         StreamBuilder<List<CloudCategory>>(
//           stream: _noteService.allCategories(ownerUserId: noteId),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             }
//             categoryNote = snapshot.data!;

//             // Process and display existing categories here
//             // You can use snapshot.data.docs to access category documents
//             // and build your UI accordingly.

//             return Expanded(
//               child: ListView.builder(
//                 itemCount: allNotes.length,
//                 itemBuilder: ((context, index) {
//                   // You can use moveNote here if needed
//                   return Container(
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: const Color.fromARGB(255, 4, 94, 211)
//                           .withOpacity(0.2),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Center(
//                           child: Text(
//                             allNotes[index].title,
//                             maxLines: 2,
//                             style: GoogleFonts.nunito(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             IconButton(
//                               onPressed: (() {}),
//                               icon: Icon(Icons.delete),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }



// // List<CloudNote> getNotesFromNotesPage(BuildContext context) {
// //   // Use a GlobalKey to access the state of the NotesPage
// //   final GlobalKey<_BottonSheetNoteListState> bottonSheetNoteListKey =
// //       GlobalKey<_BottonSheetNoteListState>();

// //   // Access the state and get the list of notes
// //   final _BottonSheetNoteListState? bottonSheetNoteListState =
// //       bottonSheetNoteListKey.currentState;
// //   if (bottonSheetNoteListState != null) {
// //     return bottonSheetNoteListState.latestList;
// //   }

// //   // If the state is not available, return an empty list or handle it as needed.
// //   return [];
// // }
