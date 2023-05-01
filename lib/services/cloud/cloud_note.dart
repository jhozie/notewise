import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'cloud_storage_constants.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;
  final String title;
  bool isPinned;
  DateTime lastUpdated;

  CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
    required this.title,
    this.isPinned = false,
    required this.lastUpdated,
  });
  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] ?? '',
        title = snapshot.data()[titleFieldName] ?? '',
        isPinned = snapshot.data()[isPinnedName] ?? false,
        lastUpdated = snapshot.data()[lastUpdatedName] != null
            ? (snapshot.data()[lastUpdatedName] as Timestamp).toDate()
            : DateTime.now();
}
// lastUpdated = snapshot.data()[lastUpdatedName] != null
  //     ? (snapshot.data()[lastUpdatedName] as Timestamp).toDate()
  //     : null;