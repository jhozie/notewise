import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/cloud/cloud_note.dart';
import '../services/cloud/firebase_cloud_note.dart';
import 'package:intl/intl.dart';

typedef CloudNameFunction = void Function(CloudNote note);

Widget noteListView(
    {required List<CloudNote> notes, required CloudNameFunction onTap}) {
  notes.sort((a, b) {
    return b.lastUpdated.compareTo(a.lastUpdated);
  });

  return Column(children: [
    ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          final note = notes.elementAt(index);
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Slidable(
              endActionPane:
                  ActionPane(motion: const BehindMotion(), children: [
                SlidableAction(
                  onPressed: ((context) async {
                    await FireBaseCloudStorage()
                        .deleteNote(documentId: note.documentId);
                  }),
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                )
              ]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 247, 247, 247),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: (() {
                    onTap(note);
                  }),
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    note.title,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  isThreeLine: true,
                  subtitle: Text(
                    note.text,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing:
                      // Checkbox(
                      // value: note.isPinned,
                      // onChanged: ((value) {
                      //   note.isPinned = !note.isPinned;
                      //   FireBaseCloudStorage().updateNote(
                      //       documentId: note.documentId,
                      //       title: note.title,
                      //       text: note.text,
                      //       ispinned: note.isPinned,
                      //       lastUpdated: note.lastUpdated);
                      // }))
                      TextButton(
                    onPressed: (() {}), // work on later
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.red.withOpacity(0.1))),
                    child: Text(
                        '${note.lastUpdated.day}/${note.lastUpdated.month}/${note.lastUpdated.year}'),
                  ),
                ),
              ),
            ),
          );
        }),
        separatorBuilder: ((context, index) {
          return const SizedBox(height: 10);
        }),
        itemCount: notes.length),
  ]);
}

class NoteListView extends StatefulWidget {
  NoteListView({
    Key? key,
    required this.notes,
    required this.onTap,
    // required this.listCount,
    // required this.date,
  }) : super(key: key);

  List<CloudNote> notes;
  final CloudNameFunction onTap;
  // final String date;
  // final int listCount;
  // CloudNote? note;
  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  @override
  Widget build(BuildContext context) {
    // widget.notes.sort((a, b) {
    //   if (a.isPinned == b.isPinned) {
    //     return b.lastUpdated.compareTo(a.lastUpdated);
    //   } else {
    //     return a.isPinned ? -1 : 1;
    //   }
    // });
    // final date = widget.note?.lastUpdated ?? DateTime.now();
    widget.notes.sort((a, b) {
      return b.lastUpdated.compareTo(a.lastUpdated);
    });
    String formatTimestamp(DateTime timestamp) {
      final now = DateTime.now();
      final difference = now.difference(timestamp);

      if (difference.inSeconds < 60) {
        return '${difference.inSeconds} seconds ago';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inHours < 24) {
        final hours = difference.inHours;
        final minutes = difference.inMinutes.remainder(60);
        return '$hours ${hours > 1 ? 'hours' : 'hour'} ${minutes > 0 ? '$minutes minutes' : ''} ago';
      } else {
        final days = difference.inDays;
        return '$days ${days > 1 ? 'days' : 'day'} ago';
      }
    }

    return Column(children: [
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            final note = widget.notes.elementAt(index);
            // var formattedTime = DateFormat.yMd().add_Hms().format(note
            //     .lastUpdated); // Customize the date and time format as needed
            var formattedTime = formatTimestamp(note.lastUpdated);

            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Slidable(
                endActionPane:
                    ActionPane(motion: const BehindMotion(), children: [
                  SlidableAction(
                    onPressed: ((context) async {
                      await FireBaseCloudStorage()
                          .deleteNote(documentId: note.documentId);
                    }),
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                  )
                ]),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 247, 247, 247),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: (() {
                      widget.onTap(note);
                    }),
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      note.title,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    isThreeLine: true,
                    subtitle: Text(
                      note.text,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing:
                        // Checkbox(
                        // value: note.isPinned,
                        // onChanged: ((value) {
                        //   note.isPinned = !note.isPinned;
                        //   FireBaseCloudStorage().updateNote(
                        //       documentId: note.documentId,
                        //       title: note.title,
                        //       text: note.text,
                        //       ispinned: note.isPinned,
                        //       lastUpdated: note.lastUpdated);
                        // }))
                        TextButton(
                            onPressed: (() {}), // work on later
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.red.withOpacity(0.1))),
                            child: Text(formattedTime)
                            // '${note.lastUpdated.day}/${note.lastUpdated.month}/${note.lastUpdated.year}'),
                            ),
                  ),
                ),
              ),
            );
          }),
          separatorBuilder: ((context, index) {
            return const SizedBox(height: 10);
          }),
          itemCount: widget.notes.length),
    ]);
  }
}

class MySearchField extends StatelessWidget {
  MySearchField({
    // required this.notes,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  // List<CloudNote> notes;
  Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChanged(value),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        hintText: 'hint',
        border: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 4, 94, 211), width: 2),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 4, 94, 211).withOpacity(0.2),
              width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}
