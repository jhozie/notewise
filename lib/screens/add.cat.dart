import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/screens/note_list.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/services/cloud/cloud_category.dart';
import 'package:notewise/services/cloud/firebase_cloud_note.dart';
import '../services/cloud/cloud_note.dart';

class AddCategoryNote extends StatefulWidget {
  const AddCategoryNote({super.key});

  @override
  State<AddCategoryNote> createState() => _AddCategoryNote();
}

class _AddCategoryNote extends State<AddCategoryNote> {
  final _selectedIndex = 0;
  late final FireBaseCloudStorage _categoryNoteService;
  final noteId = AuthService.firebase().currentUser!.id;
  List<CloudNote> allNotes = [];
  List<CloudCategory> categoryNote = [];
  int categoryIndex = 0;
  @override
  void initState() {
    _categoryNoteService = FireBaseCloudStorage();
    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void showCategorySelectionDialog(BuildContext context, CloudNote noteToMove) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Category"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display a list of categories for selection
              for (var category
                  in categoryNote.map((notes) => notes.notes).toList())
                for (var note in category)
                  for (var id in categoryNote)
                    ListTile(
                      title: Text(note.title),
                      onTap: () {
                        // Move the note to the selected category
                        // category.add(noteToMove);
                        // _categoryNoteService.updateListCategory(
                        //   documentId: id.id,
                        //   categoryNotes: category,
                        // );
                        // Navigator.pop(context); // Close the dialog
                        setState(() {}); // Rebuild the widget
                      },
                    ),
            ],
          ),
        );
      },
    );
  }

  void showAddNoteBottomSheet(BuildContext context) {
    scaffoldKey.currentState?.showBottomSheet((context) {
      return Container(
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.blueAccent,
          ),
          child: ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(allNotes[index].title),
                  onTap: () {
                    moveNote(index, categoryIndex);
                  },
                );
              })));
    });
  }

  Future<void> moveNote(int allNotesIndex, int categoryIndex) async {
    // Check if the indices are within bounds
    if (allNotesIndex >= 0 &&
        allNotesIndex < allNotes.length &&
        categoryIndex >= 0 &&
        categoryIndex < categoryNote.length) {
      final noteToMove = allNotes[allNotesIndex];

      // Add the note to the destination list
      categoryNote[categoryIndex].notes.add(noteToMove);

      // Remove the note from the source list
      allNotes.remove(noteToMove);

      // Update Firestore here if needed
      await _categoryNoteService.updateListCategory(
          documentId: categoryNote[categoryIndex].id,
          categoryName: categoryNote[categoryIndex].name,
          categoryNotes: categoryNote[categoryIndex].notes);

      // Call setState to rebuild the widget
      setState(() {});
    } else {
      print(
          "Invalid indices: allNotesIndex=$allNotesIndex, categoryIndex=$categoryIndex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButton: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(59),
            color: const Color.fromARGB(255, 4, 94, 211),
          ),
          child: IconButton(
            onPressed: () {
              showAddNoteBottomSheet(context);
            },
            icon: const Icon(
              Icons.post_add,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            IconButton(
                onPressed: (() {
                  Navigator.of(context).pushNamed(note);
                }),
                icon: Icon(Icons.arrow_back)),
            // Fetch existing notes
            StreamBuilder<List<CloudNote>>(
              stream: _categoryNoteService.allNotes(ownerUserId: noteId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                allNotes = snapshot.data!;
                // Process and display existing notes here
                // You can use snapshot.data.docs to access note documents
                // and build your UI accordingly.

                return Expanded(
                  child: Container(
                      child: ListView.builder(
                          itemCount: allNotes.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              title: Text(allNotes[index].title),
                              onTap: () {
                                moveNote(index, categoryIndex);
                              },
                            );
                          }))),
                );
              },
            ),

            StreamBuilder<List<CloudCategory>>(
              stream: _categoryNoteService.allCategories(ownerUserId: noteId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                categoryNote = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: categoryNote.length,
                    itemBuilder: ((context, index) {
                      categoryIndex = index;
                      final category = categoryNote[categoryIndex];

                      // Use a StreamBuilder to listen for changes in category.notes
                      return StreamBuilder<List<CloudNote>>(
                        stream: _categoryNoteService.getCategoryNotesStream(
                          documentId:
                              category.id, // Provide the category document ID
                        ),
                        builder: (context, notesSnapshot) {
                          if (!notesSnapshot.hasData) {
                            return Center(child: Text('No Notes Yet'));
                          }

                          // Extract the notes from the stream snapshot
                          final categoryNotes = notesSnapshot.data!;
                          print(
                              'Category: ${category.id}, Notes Count: ${category.notes}');

                          // Iterate through notes in the category and extract titles
                          final noteTitles =
                              categoryNotes.map((note) => note.title).toList();

                          return ListTile(
                            title: Column(
                              children: [
                                for (final title in noteTitles)
                                  Text(
                                    title,
                                    style: TextStyle(fontSize: 16),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
