import 'package:flutter/material.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/services/cloud/cloud_note.dart';
import 'package:notewise/services/cloud/firebase_cloud_note.dart';

class CreateUpdateNote extends StatefulWidget {
  const CreateUpdateNote({super.key});

  @override
  State<CreateUpdateNote> createState() => _CreateUpdateNoteState();
}

class _CreateUpdateNoteState extends State<CreateUpdateNote> {
  late TextEditingController _textController;
  CloudNote? _note;
  late FireBaseCloudStorage _noteService;

  @override
  void initState() {
    _noteService = FireBaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  Future<CloudNote> createNote() async {
    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final ownerUserId = currentUser.id;
    final newNote = await _noteService.createNote(ownerUserId: ownerUserId);

    _note = newNote;
    return newNote;
  }

  void _deleteNoteifEmpty() {
    final note = _note;
    if (note != null && _textController.text.isEmpty) {
      _noteService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfNotEmpty() {
    final note = _note;
    if (_textController.text.isNotEmpty && note != null) {
      _noteService.updateNote(
        documentId: note.documentId,
        title: note.title,
        text: note.text,
      );
    }
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }

    final text = _textController.text;
    await _noteService.updateNote(
        documentId: note.documentId, title: text, text: text);
  }

  void setUpTextControllerListener() {
    _textController.removeListener(() {
      _textControllerListener;
    });
    _textController.addListener(() {
      _textControllerListener;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _deleteNoteifEmpty();
    _saveNoteIfNotEmpty();
    _textControllerListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    child: IconButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                        }),
                        icon: const Icon(Icons.arrow_back)),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter text',
                      contentPadding: EdgeInsets.all(15)),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              )
            ],
          )),
    ));
  }
}
