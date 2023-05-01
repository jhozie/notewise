import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/services/cloud/cloud_storage_constants.dart';
import 'package:notewise/utilities/randon_colors.dart';

import '../Route/route.dart';
import '../services/cloud/cloud_note.dart';

class MyGridContainer extends StatelessWidget {
  const MyGridContainer({
    super.key,
    required this.notes,
  });

  final List<CloudNote> notes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2, top: 20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          int _randomIndex = Random().nextInt(colours.length);
          final note = notes.elementAt(index);
          return InkWell(
            onTap: <CloudNote>() {
              Navigator.of(context).pushNamed(newNote, arguments: note);
            },
            child: Container(
              // width: 200,
              // height: 100,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colours[_randomIndex],
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
                      maxLines: 2,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      note.text,
                      maxLines: 5,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                    ),
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
