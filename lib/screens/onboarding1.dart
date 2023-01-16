import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../main.dart';

class Onboarding1 extends StatelessWidget {
  Onboarding1({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Image.asset('images/image1.jpg'),
              ),
              Text('Scribble down your notes easily anytime, anywhere',
                  style: GoogleFonts.nunito(
                      fontSize: 30, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              const MyText(
                text: 'Please sign in to continue',
                fontsize: 20,
              ),
              const SizedBox(height: 20),
              SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: const ExpandingDotsEffect(),
              )
              // ElevatedButton(
              //     onPressed: (() {}),
              //     style: ElevatedButton.styleFrom(
              //         backgroundColor: const Color.fromARGB(255, 37, 105, 207),
              //         minimumSize: const Size(400, 60),
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10))),
              //     child: const Text(
              //       'Login',
              //       style: TextStyle(fontSize: 20, fontFamily: 'nunito'),
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
