import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/utilities/randon_colors.dart';

import '../Route/route.dart';
import '../services/cloud/cloud_note.dart';

class MyNoteContainer extends StatelessWidget {
  const MyNoteContainer({
    super.key,
    required this.notes,
  });

  final List<CloudNote> notes;
  @override
  Widget build(BuildContext context) {
    notes.sort((a, b) {
      return b.lastUpdated.compareTo(a.lastUpdated);
    });
    final List<CloudNote> pinnedNotes =
        notes.where((notes) => notes.isPinned).toList();
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 20, left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pinnedNotes.length,
        itemBuilder: (context, index) {
          int _randomIndex = Random().nextInt(colourss.length);
          final note = pinnedNotes.elementAt(index);
          return InkWell(
            onTap: <CloudNote>() {
              Navigator.of(context).pushNamed(newNote, arguments: note);
            },
            child: Container(
              width: 200,
              height: 100,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colourss[_randomIndex],
                // const Color.fromARGB(255, 4, 94, 211).withOpacity(0.2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 14, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      note.text,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: (() {}),
                            icon: Icon(
                              note.isPinned ? Icons.push_pin : null,
                              size: 15,
                            )),
                        SizedBox(
                          width: 1,
                        ),
                        Text(note.isPinned ? 'Pinned' : '',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
