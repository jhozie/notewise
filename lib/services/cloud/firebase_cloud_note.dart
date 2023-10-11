// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:notewise/Route/route.dart';
// import 'package:notewise/screens/allNotes.dart';
// import 'package:notewise/services/cloud/cloud_category.dart';
// import 'package:notewise/services/cloud/cloud_note.dart';
// import 'package:notewise/services/cloud/cloud_storage_constants.dart';
// import 'package:notewise/services/cloud/cloud_storage_exceptions.dart';

// class FireBaseCloudStorage {
//   final notes = FirebaseFirestore.instance.collection('notes');
//   final categories = FirebaseFirestore.instance.collection('categories');
//   Stream<List<CloudNote>> allNotes({required String ownerUserId}) =>
//       notes.snapshots().map((event) => event.docs
//           .map((doc) => CloudNote.fromSnapshot(doc))
//           .where((note) => note.ownerUserId == ownerUserId)
//           .toList());

//   Stream<List<CloudCategory>> allCategories({required String ownerUserId}) =>
//       categories.snapshots().map((event) => event.docs
//           .map((doc) => CloudCategory.fromSnapshot(doc))
//           .where((category) => category.ownerUserId == ownerUserId)
//           .toList());

//   Future<CloudNote> createNote({required String ownerUserId}) async {
//     final now = DateTime.now();

//     final document = await notes.add({
//       ownerUserIdFieldName: ownerUserId,
//       titleFieldName: '',
//       textFieldName: '',
//       'createdAt': ''
//     });

//     final fetchNote = await document.get();

//     return CloudNote(
//         documentId: fetchNote.id,
//         ownerUserId: ownerUserId,
//         text: '',
//         title: '',
//         lastUpdated: now);
//   }

//   // Future<CloudCategory> createCategory({required String ownerUserId}) async {
//   //   final document = await categories.add({
//   //     ownerUserIdFieldName: ownerUserId,
//   //     catergoryName: '',
//   //   });

//   //   final fetchCategory = await document.get();

//   //   return CloudCategory(
//   //     id: fetchCategory.id,
//   //     name: '',
//   //     ownerUserId: ownerUserId,
//   //   );
//   // }
//   Future<CloudCategory> createCategory({
//     required String ownerUserId,
//     required String categoryName,
//     // required List<CloudNote> addNewList
//     // Added parameter
//   }) async {
//     final document = await categories.add({
//       ownerUserIdFieldName: ownerUserId,
//       catergoryName: categoryName, // Use the provided categoryName
//     });

//     final fetchCategory = await document.get();

//     return CloudCategory(
//       id: fetchCategory.id,
//       name: categoryName, // Use the provided categoryName
//       ownerUserId: ownerUserId,
//       // notes: [],
//     );
//   }

//   Future<List<CloudNote>> getNotes({required String ownerUserId}) async {
//     try {
//       return await notes
//           .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
//           .orderBy('isPinned', descending: true)
//           .orderBy('createdAt', descending: true)
//           .get()
//           .then((value) => value.docs.map((doc) {
//                 return CloudNote.fromSnapshot(doc);
//               }).toList());
//     } catch (e) {
//       throw CouldNotGetAllNoteException();
//     }
//   }

//   Future<List<CloudCategory>> getCategories(
//       {required String ownerUserId}) async {
//     try {
//       return await categories
//           .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
//           .get()
//           .then((value) => value.docs
//               .map((doc) => CloudCategory.fromSnapshot(doc))
//               .toList());
//     } catch (e) {
//       throw CouldNotCreateCategoryException();
//     }
//   }

//   Future<void> updateNote({
//     required String documentId,
//     required String title,
//     required String text,
//     bool ispinned = false,
//     DateTime? lastUpdated,
//   }) async {
//     try {
//       await notes.doc(documentId).update({
//         titleFieldName: title,
//         textFieldName: text,
//         isPinnedName: ispinned,
//         lastUpdatedName: FieldValue.serverTimestamp()
//       });
//     } catch (e) {
//       throw CouldNotUpdateNoteException();
//     }
//   }

//   Future<void> updateCategory(
//       {required String documentId, required String categoryName}) async {
//     try {
//       await categories.doc(documentId).update({
//         catergoryName: categoryName,
//       });
//     } catch (e) {
//       throw CouldNotUpdateCategoryException();
//     }
//   }

//   // Future<void> updateListCategory({
//   //   required String documentId,
//   //   // required String categoryName,
//   //   required List<CloudNote> addList, // Pass a list of CloudNotes to add
//   // }) async {
//   //   try {
//   //     // final document = await categories.add({
//   //     //   // catergoryName: categoryName, // Use the provided categoryName
//   //     // });

//   //     // final fetchCategory = await document.get();

//   //     await categories.doc(documentId).update({
//   //       // catergoryName: categoryName,
//   //       'notes': addList
//   //           .map((note) => note.toMap())
//   //           .toList(), // Convert CloudNotes to Map
//   //     });
//   //   } catch (e) {
//   //     throw CouldNotUpdateCategoryException();
//   //   }
//   // }

//   Future<void> deleteNote({required documentId}) async {
//     await notes.doc(documentId).delete();
//   }

//   Future<void> deleteCategory({required documentId}) async {
//     await categories.doc(documentId).delete();
//   }

//   static final FireBaseCloudStorage _shared =
//       FireBaseCloudStorage._sharedInstance();
//   FireBaseCloudStorage._sharedInstance();
//   factory FireBaseCloudStorage() => _shared;
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notewise/services/cloud/cloud_category.dart';
import 'package:notewise/services/cloud/cloud_note.dart';
import 'package:notewise/services/cloud/cloud_storage_constants.dart';
import 'package:notewise/services/cloud/cloud_storage_exceptions.dart';

class FireBaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');
  final categories = FirebaseFirestore.instance.collection('categories');
  Stream<List<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapshot(doc))
          .where((note) => note.ownerUserId == ownerUserId)
          .toList());

  Stream<List<CloudCategory>> allCategories({required String ownerUserId}) =>
      categories.snapshots().map((event) => event.docs
          .map((doc) => CloudCategory.fromSnapshot(doc))
          .where((category) => category.ownerUserId == ownerUserId)
          .toList());

  Future<CloudNote> createNote({required String ownerUserId}) async {
    final now = DateTime.now();

    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      titleFieldName: '',
      textFieldName: '',
      'createdAt': ''
    });

    final fetchNote = await document.get();

    return CloudNote(
        documentId: fetchNote.id,
        ownerUserId: ownerUserId,
        text: '',
        title: '',
        lastUpdated: now);
  }

  // Future<CloudCategory> createCategory({
  //   required String ownerUserId,
  //   required String categoryName,
  //   required List<CloudNote> notes,
  //   // Added parameter
  // }) async {
  //   final document = await categories.add({
  //     ownerUserIdFieldName: ownerUserId,
  //     catergoryName: categoryName, // Use the provided categoryName
  //   });

  //   final fetchCategory = await document.get();

  //   return CloudCategory(
  //       id: fetchCategory.id,
  //       name: categoryName, // Use the provided categoryName
  //       ownerUserId: ownerUserId,
  //       notes: notes);
  // }

  Future<CloudCategory> createCategory({
    required String ownerUserId,
    required String categoryName,
  }) async {
    try {
      // Add a new category document to the Firestore collection
      final document = await categories.add({
        ownerUserIdFieldName: ownerUserId,
        catergoryName: categoryName,
        'notes': [], // Initialize an empty list for notes
      });

      // Get the newly created category document from Firestore
      final fetchCategory = await document.get();

      // Create a CloudCategory object and return it
      return CloudCategory(
        id: fetchCategory.id,
        name: categoryName,
        ownerUserId: ownerUserId,
        notes: [], // Initialize the notes field as an empty list
      );
    } catch (e) {
      throw CouldNotCreateCategoryException();
    }
  }

  Future<List<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .orderBy('isPinned', descending: true)
          .orderBy('createdAt', descending: true)
          .get()
          .then((value) => value.docs.map((doc) {
                return CloudNote.fromSnapshot(doc);
              }).toList());
    } catch (e) {
      throw CouldNotGetAllNoteException();
    }
  }

  Future<List<CloudCategory>> getCategories(
      {required String ownerUserId}) async {
    try {
      return await categories
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .get()
          .then((value) => value.docs
              .map((doc) => CloudCategory.fromSnapshot(doc))
              .toList());
    } catch (e) {
      throw CouldNotCreateCategoryException();
    }
  }

  Stream<List<CloudNote>> getCategoryNotesStream({required String documentId}) {
    try {
      // Reference to the category document
      final categoryRef =
          FirebaseFirestore.instance.collection('categories').doc(documentId);

      // Reference to the 'notes' subcollection within the category
      final notesRef = categoryRef.collection('notes');

      // Create a stream of notes within the 'notes' subcollection
      return notesRef.snapshots().map((snapshot) {
        final notesList =
            snapshot.docs.map((doc) => CloudNote.fromSnapshot(doc)).toList();
        return notesList;
      });
    } catch (e) {
      print('Error getting category notes stream: $e');
      throw e;
    }
  }

  Stream<List<CloudNote>> streamSubCollectionData(String mainDocId) {
    return FirebaseFirestore.instance
        .collection('categories')
        .doc(mainDocId)
        .collection('notes')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<CloudNote> subCollectionList = [];
      querySnapshot.docs.forEach((doc) {
        // Convert each document to a map and add it to the list
        subCollectionList.add(doc.data() as CloudNote);
      });
      return subCollectionList;
    });
  }

  Future<void> updateNote({
    required String documentId,
    required String title,
    required String text,
    bool ispinned = false,
    DateTime? lastUpdated,
  }) async {
    try {
      await notes.doc(documentId).update({
        titleFieldName: title,
        textFieldName: text,
        isPinnedName: ispinned,
        lastUpdatedName: FieldValue.serverTimestamp()
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  // Future<void> updateCategory(
  //     {required String documentId, required String categoryName}) async {
  //   try {
  //     await categories.doc(documentId).update({
  //       catergoryName: categoryName,
  //     });
  //   } catch (e) {
  //     throw CouldNotUpdateCategoryException();
  //   }
  // }

  // Future<void> updateListCategory({
  //   required String documentId,
  //   required List<CloudNote> categoryNotes,
  // }) async {
  //   try {
  //     await categories.doc(documentId).update({isAddList: categoryNotes});
  //   } catch (e) {
  //     throw CouldNotUpdateCategoryException();
  //   }
  // }

  Future<void> deleteNote({required documentId}) async {
    await notes.doc(documentId).delete();
  }

  Future<void> deleteCategory({required documentId}) async {
    await categories.doc(documentId).delete();
  }

  Future<void> updateListCategory({
    required String documentId,
    required String categoryName,
    required List<CloudNote> categoryNotes,
  }) async {
    try {
      // Reference to the category document
      DocumentReference categoryRef = categories.doc(documentId);

      // Get the current data of the category document
      DocumentSnapshot categorySnapshot = await categoryRef.get();

      // Check if the category document exists
      if (!categorySnapshot.exists) {
        throw Exception('Category document does not exist.');
      }

      // Extract the existing notes data from the document
      Map<String, dynamic>? data =
          categorySnapshot.data() as Map<String, dynamic>?;

      List<Map<String, dynamic>> existingNotesData =
          List<Map<String, dynamic>>.from(data?['notes'] ?? []);

      // Convert the list of new CloudNote objects into a List<Map<String, dynamic>>
      List<Map<String, dynamic>> newNotesData =
          categoryNotes.map((note) => note.toMap()).toList();

      // Merge the new notes data with the existing notes data
      List<Map<String, dynamic>> mergedNotesData = List.from(existingNotesData)
        ..addAll(newNotesData);

      // Update the category document with the merged notes data and new category name
      await categoryRef.update({
        'categoryName': categoryName,
        'notes': mergedNotesData,
      });
    } catch (e) {
      print('Error updating category: $e');
      throw CouldNotUpdateCategoryException();
    }
  }

  static final FireBaseCloudStorage _shared =
      FireBaseCloudStorage._sharedInstance();
  FireBaseCloudStorage._sharedInstance();
  factory FireBaseCloudStorage() => _shared;
}
