import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  const MyText({
    required this.text,
    required this.fontsize,
    Key? key,
  }) : super(key: key);

  final String text;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.nunito(
            fontSize: fontsize,
            color: Theme.of(context).brightness == Brightness.light
                ? Color.fromARGB(255, 88, 88, 88)
                : const Color.fromARGB(255, 218, 216, 216)));
  }
}
