import '../../cloud/cloud_note.dart';

abstract class NoteState {}

class InitialNoteState extends NoteState {}

class SearchResultsState extends NoteState {
  final List<CloudNote> searchResults;

  SearchResultsState(this.searchResults);
}
