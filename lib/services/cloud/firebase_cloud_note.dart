import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notewise/services/cloud/cloud_note.dart';
import 'package:notewise/services/cloud/cloud_storage_constants.dart';
import 'package:notewise/services/cloud/cloud_storage_exceptions.dart';

class FireBaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  Stream<List<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapshot(doc))
          .where((note) => note.ownerUserId == ownerUserId)
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

  Future<void> deleteNote({required documentId}) async {
    await notes.doc(documentId).delete();
  }

  static final FireBaseCloudStorage _shared =
      FireBaseCloudStorage._sharedInstance();
  FireBaseCloudStorage._sharedInstance();
  factory FireBaseCloudStorage() => _shared;
}
