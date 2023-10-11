abstract class NoteEvent {}

class SearchQueryChanged extends NoteEvent {
  final String query;

  SearchQueryChanged(this.query);
}
