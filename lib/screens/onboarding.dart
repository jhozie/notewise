import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/Route/route.dart';
import 'package:notewise/screens/slider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentPage = 0;
  PageController _controller = PageController();

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<Widget> _page = const [
    Pages(
        title: 'Scribble down your notes easily anytime, anywhere',
        description:
            'Your notes auto syncronise across all device making it easy to take note on the goal',
        image: 'images/image1.jpg'),
    Pages(
        title: 'Enjoy flexible interface',
        description: 'Capture whatever you want to remember',
        image: 'images/image1.jpg'),
    Pages(
        title: 'Track your notes and reflect your day',
        description: 'Get an overview of your entire note catelog',
        image: 'images/image1.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                itemCount: _page.length,
                onPageChanged: _onChanged,
                itemBuilder: ((context, index) {
                  return _page[index];
                })),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_page.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 10,
                      width: (index == _currentPage) ? 30 : 10,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == _currentPage)
                              ? const Color.fromARGB(255, 37, 105, 207)
                              : const Color.fromARGB(255, 37, 105, 207)
                                  .withOpacity(0.5)),
                    );
                  }),
                ),
                InkWell(
                  onTap: (() {
                    _currentPage == (_page.length - 1)
                        ? Navigator.of(context)
                            .popAndPushNamed(RouteManager.login)
                        : _controller.nextPage(
                            duration: Duration(microseconds: 300),
                            curve: Curves.easeInOut);
                  }),
                  child: AnimatedContainer(
                      duration: const Duration(microseconds: 300),
                      alignment: Alignment.center,
                      height: 50,
                      width: _currentPage == (_page.length - 1) ? 350 : 50,
                      decoration: BoxDecoration(
                        borderRadius: _currentPage == (_page.length - 1)
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 37, 105, 207),
                      ),
                      child: _currentPage == (_page.length - 1)
                          ? Text(
                              'Continue',
                              style: GoogleFonts.nunito(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )),
                ),
                const SizedBox(height: 1),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: (() {
                        Navigator.of(context)
                            .popAndPushNamed(RouteManager.login);
                      }),
                      child: Text(
                        'Skip Tour',
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
