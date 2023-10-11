import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/auth/auth_service.dart';
import '../services/cloud/cloud_category.dart';
import '../services/cloud/cloud_note.dart';
import '../services/cloud/firebase_cloud_note.dart';

class NoteCategoryPage extends StatefulWidget {
  const NoteCategoryPage({super.key});

  @override
  State<NoteCategoryPage> createState() => _NoteCategoryPageState();
}

class _NoteCategoryPageState extends State<NoteCategoryPage> {
  late final FireBaseCloudStorage _categoryNoteService;
  final noteId = AuthService.firebase().currentUser!.id;
  List<CloudCategory> categoryNote = [];
  int categoryIndex = 0;
  @override
  void initState() {
    _categoryNoteService = FireBaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes in Categories'),
      ),
      body: StreamBuilder<List<CloudCategory>>(
        stream: _categoryNoteService.allCategories(ownerUserId: noteId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No categories found.');
          } else {
            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(category.name),
                  subtitle: StreamBuilder<List<CloudNote>>(
                    stream: _categoryNoteService.getCategoryNotesStream(
                        documentId: category.id),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No data availale.');
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var documentData =
                              snapshot.data! as Map<String, dynamic>;
                          var mapList =
                              documentData['notes'] as List<CloudNote>;

                          // Create a ListView to display titles from the mapList
                          return Column(
                            children: mapList.map<Widget>((map) {
                              var title = map.title;
                              return ListTile(
                                title: Text(title),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
