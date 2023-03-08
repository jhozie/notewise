import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notewise/services/cloud/cloud_note.dart';
import 'package:notewise/services/cloud/cloud_storage_constants.dart';
import 'package:notewise/services/cloud/cloud_storage_exceptions.dart';

class FireBaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapshot(doc))
          .where((note) => note.ownerUserId == ownerUserId));

  Future<CloudNote> createNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      titleFieldName: '',
      textFieldName: '',
    });

    final fetchNote = await document.get();

    return CloudNote(
        documentId: fetchNote.id,
        ownerUserId: ownerUserId,
        text: '',
        title: '');
  }

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .get()
          .then((value) => value.docs.map((doc) {
                return CloudNote.fromSnapshot(doc);
              }));
    } catch (e) {
      throw CouldNotGetAllNoteException();
    }
  }

  Future<void> updateNote(
      {required String documentId,
      required String title,
      required String text}) async {
    try {
      await notes.doc(documentId).update({
        titleFieldName: title,
        textFieldName: text,
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
