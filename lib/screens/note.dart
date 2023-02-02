import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:notewise/firebase_options.dart';
import 'package:notewise/utilities/showdialog.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _itemList = <Map<String, String>>[
    {
      'title': 'Cooking Tips',
      'content': 'I will show you how to make this recipe'
    },
    {
      'title': 'Cooking Tips',
      'content': 'I will show you how to make this recipe'
    },
    {
      'title': 'Cooking Tips',
      'content': 'I will show you how to make this recipe'
    },
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: FutureBuilder(
            future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return SingleChildScrollView(
                    child: Container(
                      color: const Color.fromARGB(255, 243, 243, 243),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Notes',
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: const Color.fromARGB(
                                            255, 88, 88, 88)),
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    child: InkWell(
                                      onTap: (() async {
                                        await showLogOutDialog(context,
                                            title: 'Log Out',
                                            description:
                                                'Are you sure you want to log out?');
                                      }),
                                      child: const CircleAvatar(
                                        radius: 17,
                                        backgroundImage: AssetImage(
                                            'images/avatar-woman.jpg'),
                                      ),
                                    ),
                                  )
                                ]),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 20),
                                labelText: 'label',
                                hintText: 'hint',
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 4, 94, 211),
                                      width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 4, 94, 211)
                                              .withOpacity(0.2),
                                      width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _itemList.length,
                                  itemBuilder: ((context, index) {
                                    return MyNoteContainer(
                                        title:
                                            _itemList[index]['title'] as String,
                                        content: _itemList[index]['content']
                                            as String);
                                  })),
                            ),
                            Container(
                              constraints:
                                  const BoxConstraints.expand(height: 60),
                              child: TabBar(
                                indicator: const UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 4, 94, 211),
                                      width: 4,
                                    ),
                                    insets:
                                        EdgeInsets.symmetric(horizontal: 40)),
                                labelStyle: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                labelColor: Colors.black,
                                tabs: const [
                                  Tab(
                                    text: 'Recent',
                                  ),
                                  Tab(text: 'Favorite'),
                                ],
                                isScrollable: true,
                              ),
                            ),
                            Container(
                              height: 150,
                              child: TabBarView(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Text(
                                            'Notes',
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: const Color.fromARGB(
                                                    255, 88, 88, 88)),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              left: BorderSide(
                                                  width: 7, color: Colors.blue),
                                            ),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            title: const Text('Title'),
                                            trailing: ElevatedButton(
                                                onPressed: (() {}),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .amber
                                                        .withOpacity(0.6)),
                                                child: const Text('data')),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10))),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Text(
                                            'Notes',
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: const Color.fromARGB(
                                                    255, 88, 88, 88)),
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              left: BorderSide(
                                                  width: 7, color: Colors.blue),
                                            ),
                                          ),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: const ListTile(
                                            tileColor: Colors.white,
                                            contentPadding: EdgeInsets.all(15),
                                            title: Text('Title'),
                                            trailing: Text('data'),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Center(child: Text('Content of Tab 2')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            })),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'One'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined), label: 'Two'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined), label: 'three'),
          ],
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}

class MyNoteContainer extends StatelessWidget {
  const MyNoteContainer({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 4, 94, 211).withOpacity(0.2)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                content,
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
  }
}
