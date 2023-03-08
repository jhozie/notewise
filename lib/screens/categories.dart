import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: const [
                SizedBox(height: 100, child: Icon(Icons.arrow_back_ios_new)),
              ],
            ),
            Text(
              'Categories',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: const Color.fromARGB(255, 88, 88, 88)),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 180,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.withOpacity(0.5)),
                ),
                SizedBox(width: 20),
                Container(
                  height: 180,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.withOpacity(0.5)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 180,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.withOpacity(0.5)),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 180,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.withOpacity(0.5)),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
