// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:notewise/services/cloud/cloud_note.dart';
// // import 'package:notewise/services/cloud/cloud_storage_constants.dart';

// // class CloudCategory {
// //   final String id;
// //   final String name;
// //   final String ownerUserId;
// //   // final List<CloudNote> notes; // List of CloudNotes

// //   CloudCategory({
// //     required this.id,
// //     required this.name,
// //     required this.ownerUserId,
// //     // required this.notes, // Initialize it as an empty list
// //   });

// //   factory CloudCategory.fromSnapshot(DocumentSnapshot snapshot) {
// //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
// //     // Initialize notes as an empty list
// //     // List<CloudNote> notes = [];

// //     // // Check if the document contains a "notes" field
// //     // if (data.containsKey('notes')) {
// //     //   // Assuming the "notes" field contains a list of note data
// //     //   List<dynamic> notesData = data['notes'] as List<dynamic>;
// //     //   notes = notesData
// //     //       .map((noteData) => CloudNote.fromSnapshot(noteData))
// //     //       .toList();
// //     // }

// //     return CloudCategory(
// //       id: snapshot.id,
// //       ownerUserId: data[ownerUserIdFieldName],
// //       name: data[catergoryName] ?? '',
// //       // notes: notes, // Assign the list of notes
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:notewise/Route/route.dart';
// import 'package:notewise/services/cloud/cloud_storage_constants.dart';

// import 'cloud_note.dart';

// class CloudCategory {
//   final String id;
//   final String name;
//   final String ownerUserId;
//   final List<CloudNote> notes;

//   CloudCategory(
//       {required this.id,
//       required this.name,
//       required this.ownerUserId,
//       required this.notes});

//   factory CloudCategory.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return CloudCategory(
//         id: snapshot.id,
//         ownerUserId: data[ownerUserIdFieldName],
//         name: data[catergoryName] ?? '',
//         notes: List<CloudNote>.from(data[isAddList] ?? []));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notewise/services/cloud/cloud_storage_constants.dart';

import 'cloud_note.dart';

class CloudCategory {
  final String id;
  final String name;
  final String ownerUserId;
  List<CloudNote> notes;
  CloudCategory({
    required this.id,
    required this.name,
    required this.ownerUserId,
    required this.notes,
  });

  factory CloudCategory.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (!snapshot.exists) {
      throw Exception("Document does not exist");
    }

    Map<String, dynamic>? data = snapshot.data();

    List<CloudNote> notes = [];

    // if (data != null && data.containsKey('notes')) {
    //   List<dynamic> notesData = data['notes'] as List<dynamic>;
    //   notes = notesData
    //       .map((noteData) => CloudNote.fromSnapshot(noteData))
    //       .toList();
    // }
    if (data.containsKey('notes')) {
      List<dynamic> notesData =
          (data['notes'] as List<dynamic>).map((noteData) => noteData).toList();
    }

    return CloudCategory(
        id: snapshot.id,
        ownerUserId: data[ownerUserIdFieldName] ?? '', // Use null-safe operator
        name: data[catergoryName] ?? '', // Use null-safe operator
        notes: notes);
  }
}
