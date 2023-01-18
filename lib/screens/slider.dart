import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pages extends StatelessWidget {
  const Pages(
      {super.key,
      required this.title,
      required this.description,
      required this.image});
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 300,
            ),
            Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(description,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 17, fontWeight: FontWeight.normal)),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
