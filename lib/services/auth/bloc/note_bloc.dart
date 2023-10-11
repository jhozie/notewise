import 'package:bloc/bloc.dart';
import 'package:notewise/services/auth/bloc/note_event.dart';
import 'package:notewise/services/auth/bloc/note_state.dart';

import '../../cloud/cloud_note.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(InitialNoteState());

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is SearchQueryChanged) {
      // Handle search query change event here
      String query = event.query.toLowerCase();
      List<CloudNote> searchResults = []; // Perform your search logic here
      yield SearchResultsState(searchResults);
    }
  }
}
