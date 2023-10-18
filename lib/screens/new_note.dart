import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/services/auth/auth_service.dart';
import 'package:notewise/services/cloud/cloud_note.dart';
import 'package:notewise/services/cloud/firebase_cloud_note.dart';
import 'package:notewise/utilities/get_argument.dart';
import 'package:notewise/utilities/showdialog.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdateNote extends StatefulWidget {
  const CreateUpdateNote({super.key});

  @override
  State<CreateUpdateNote> createState() => _CreateUpdateNoteState();
}

class _CreateUpdateNoteState extends State<CreateUpdateNote> {
  late TextEditingController _textController;
  late TextEditingController _titleController;
  CloudNote? _note;
  late FireBaseCloudStorage _noteService;
  DateTime? updateTime;

  @override
  void initState() {
    _noteService = FireBaseCloudStorage();
    _textController = TextEditingController();
    _titleController = TextEditingController();

    super.initState();
  }

  Future<CloudNote> createNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      _titleController.text = widgetNote.title;
      return widgetNote;
    }
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
    if (note != null &&
        _textController.text.isEmpty &&
        _titleController.text.isEmpty) {
      _noteService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    final title = _titleController.text;
    if (note != null &&
        _textController.text.isNotEmpty &&
        _titleController.text.isNotEmpty) {
      await _noteService.updateNote(
        documentId: note.documentId,
        title: title,
        text: text,
        ispinned: note.isPinned,
      );
    }
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }

    final text = _textController.text;
    final title = _titleController.text;
    await _noteService.updateNote(
      documentId: note.documentId,
      title: title,
      text: text,
      ispinned: note.isPinned,
    );
  }

  void _setUpTextControllerListener() {
    _textController.removeListener(() {
      _textControllerListener;
      _titleController.removeListener(() {
        _textControllerListener;
      });
    });
    _textController.addListener(() {
      _textControllerListener;
    });
    _titleController.addListener(() {
      _textControllerListener;
    });
  }

  void _toggleAsPinned() {
    setState(() {
      final note = _note;
      note!.isPinned = !note.isPinned;
      _noteService.updateNote(
        documentId: note.documentId,
        title: note.title,
        text: note.text,
        ispinned: note.isPinned,
        lastUpdated: note.lastUpdated,
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _titleController.dispose();
    _deleteNoteifEmpty();
    _saveNoteIfNotEmpty();
    _textControllerListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: createNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // _note = snapshot.data as CloudNote;
              // _setUpTitleControllerListener();
              _setUpTextControllerListener();
              final date = _note!.lastUpdated;
              return Container(
                // color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                )),
                            const SizedBox(width: 240),
                            IconButton(
                                onPressed: _toggleAsPinned,
                                icon: Icon(
                                    _note!.isPinned
                                        ? Icons.push_pin
                                        : Icons.push_pin_outlined,
                                    color:
                                        const Color.fromARGB(255, 4, 94, 211))),
                            IconButton(
                              onPressed: (() async {
                                final title = _titleController.text;
                                final text = _textController.text;
                                if (title.isEmpty ||
                                    text.isEmpty ||
                                    _note == null) {
                                  await showShareErrorIfNoteEmpty(context);
                                } else {
                                  await Share.share(text);
                                }
                              }),
                              icon: const Icon(Icons.share),
                              color: const Color.fromARGB(255, 4, 94, 211),
                            ),
                          ],
                        ),
                        Text(
                          "${date.day}/${date.month}/${date.year}  ${date.hour}.${date.minute}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 139, 139, 139)),
                        ),
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Title',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 139, 139, 139)),
                            contentPadding:
                                EdgeInsets.only(right: 15, left: 15),
                          ),
                          keyboardType: TextInputType.multiline,
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 139, 139, 139),
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: TextField(
                            controller: _textController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tap to enter text',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 139, 139, 139)),
                              contentPadding: EdgeInsets.all(15),
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 139, 139, 139),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
