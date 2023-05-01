// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:notewise/Route/route.dart';
// import 'package:notewise/screens/note_list.dart';
// import 'package:notewise/services/auth/auth_service.dart';
// import 'package:notewise/services/cloud/firebase_cloud_note.dart';
// import 'package:notewise/utilities/showdialog.dart';

// import '../services/cloud/cloud_note.dart';

// class NoteScreen extends StatefulWidget {
//   const NoteScreen({super.key});

//   @override
//   State<NoteScreen> createState() => _NoteScreenState();
// }

// class _NoteScreenState extends State<NoteScreen> {
//   final _itemList = <Map<String, String>>[
//     {
//       'title': 'Cooking Tips',
//       'content': 'I will show you how to make this recipe'
//     },
//     {
//       'title': 'Cooking Tips',
//       'content': 'I will show you how to make this recipe'
//     },
//     {
//       'title': 'Cooking Tips',
//       'content': 'I will show you how to make this recipe'
//     },
//   ];
//   final _selectedIndex = 0;
//   late final FireBaseCloudStorage _noteService;
//   final noteId = AuthService.firebase().currentUser!.id;

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
//             color: Color.fromARGB(255, 4, 94, 211),
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
//         body: StreamBuilder(
//             stream: _noteService.allNotes(ownerUserId: noteId),
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                 case ConnectionState.active:
//                   if (snapshot.hasData) {
//                     final allNotes = snapshot.data as Iterable<CloudNote>;
//                     return SingleChildScrollView(
//                       child: Container(
//                         color: Color.fromARGB(255, 250, 250, 250),
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 50),
//                               // Circle Avatar Section
//                               Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Notes',
//                                       style: GoogleFonts.nunito(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 30,
//                                           color: const Color.fromARGB(
//                                               255, 88, 88, 88)),
//                                     ),
//                                     CircleAvatar(
//                                       radius: 20,
//                                       child: InkWell(
//                                         onTap: (() async {
//                                           await showLogOutDialog(context,
//                                               title: 'Log Out',
//                                               description:
//                                                   'Are you sure you want to log out?');
//                                         }),
//                                         child: const CircleAvatar(
//                                           radius: 17,
//                                           backgroundImage: AssetImage(
//                                               'images/avatar-woman.jpg'),
//                                         ),
//                                       ),
//                                     )
//                                   ]),
//                               const SizedBox(height: 20),
//                               //Search Field
//                               TextField(
//                                 decoration: InputDecoration(
//                                   prefixIcon: const Icon(Icons.search),
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 3, horizontal: 20),
//                                   labelText: 'label',
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
//                               // Section for Pinned Notes
//                               Container(
//                                   height: 180,
//                                   child: MyNoteContainer(notes: allNotes)),
//                               //contains tabview menu
//                               Container(
//                                 constraints:
//                                     const BoxConstraints.expand(height: 60),
//                                 child: TabBar(
//                                   indicator: const UnderlineTabIndicator(
//                                       borderSide: BorderSide(
//                                         color: Color.fromARGB(255, 4, 94, 211),
//                                         width: 4,
//                                       ),
//                                       insets:
//                                           EdgeInsets.symmetric(horizontal: 40)),
//                                   labelStyle: GoogleFonts.nunito(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20),
//                                   labelColor: Colors.black,
//                                   tabs: const [
//                                     Tab(
//                                       text: 'Recent',
//                                     ),
//                                     Tab(text: 'Favorite'),
//                                   ],
//                                   isScrollable: false,
//                                 ),
//                               ),
//                               //Contains the Tabview Content
//                               Container(
//                                 height: 200,
//                                 child: TabBarView(
//                                   children: [
//                                     SingleChildScrollView(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 20),
//                                             child: Text(
//                                               'Notes',
//                                               style: GoogleFonts.nunito(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 20,
//                                                   color: const Color.fromARGB(
//                                                       255, 88, 88, 88)),
//                                             ),
//                                           ),
//                                           NoteListView(
//                                             notes: allNotes,
//                                             onTap: (note) async {
//                                               await Navigator.of(context)
//                                                   .pushNamed(newNote,
//                                                       arguments: note);
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const Center(
//                                         child: Text('Content of Tab 2')),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   } else {
//                     return Text('data');
//                   }
//                 default:
//                   return const CircularProgressIndicator();
//               }
//             }),
//         bottomNavigationBar: BottomNavigationBar(
//           iconSize: 30,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home_outlined), label: 'Home'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.notes_outlined), label: 'Categories'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.settings_outlined), label: 'Settings'),
//           ],
//           currentIndex: _selectedIndex,
//         ),
//       ),
//     );
//   }
// }

// class MyNoteContainer extends StatelessWidget {
//   const MyNoteContainer({
//     super.key,
//     required this.notes,
//   });

//   final Iterable<CloudNote> notes;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 20, top: 20),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: notes.length,
//         itemBuilder: (context, index) {
//           final note = notes.elementAt(index);
//           return InkWell(
//             onTap: <CloudNote>() {
//               Navigator.of(context).pushNamed(newNote, arguments: note);
//             },
//             child: Container(
//               width: 200,
//               height: 100,
//               margin: EdgeInsets.only(right: 10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color:
//                       const Color.fromARGB(255, 4, 94, 211).withOpacity(0.2)),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: 20, right: 10, top: 20, bottom: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       note.title,
//                       style: GoogleFonts.nunito(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       note.text,
//                       style: GoogleFonts.nunito(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 17,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
