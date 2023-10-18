// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:notewise/Route/route.dart';
// import 'package:notewise/services/auth/auth_service.dart';
// import 'package:notewise/utilities/get_argument.dart';
// import '../services/cloud/cloud_category.dart';
// import '../services/cloud/firebase_cloud_note.dart';

// class CategoryPage extends StatefulWidget {
//   const CategoryPage({super.key});

//   @override
//   State<CategoryPage> createState() => _CategoryPageState();
// }

// class _CategoryPageState extends State<CategoryPage> {
//   CloudCategory? _category;
//   late TextEditingController _categoryNameController;
//   late FireBaseCloudStorage _categoryService;
//   final categoryId = AuthService.firebase().currentUser!.id;

//   @override
//   void initState() {
//     super.initState();
//     _categoryService = FireBaseCloudStorage();
//     _categoryNameController = TextEditingController();
//   }

//   // Future<CloudCategory> createCategor(BuildContext context) async {
//   //   final widgetcategory = context.getArgument<CloudCategory>();

//   //   if (widgetcategory != null) {
//   //     _category = widgetcategory;
//   //     _categoryNameController.text = widgetcategory.name;
//   //     return widgetcategory;
//   //   }
//   //   final existingCategory = _category;
//   //   if (existingCategory != null) {
//   //     return existingCategory;
//   //   }
//   //   final currentUser = AuthService.firebase().currentUser!;
//   //   final ownerUserId = currentUser.id;
//   //   final newCategory = await _categoryService.createCategory(ownerUserId: categoryId, categoryName: _categoryNameController.text),

//   //   _category = newCategory;
//   //   return newCategory;
//   // }
//   Future<CloudCategory> createCategory(BuildContext context) async {
//     final currentUser = AuthService.firebase().currentUser!;
//     final ownerUserId = currentUser.id;

//     // Create a new category with an empty notes list
//     final newCategory = await _categoryService.createCategory(
//       ownerUserId: ownerUserId,
//       categoryName: _categoryNameController.text,
//     );

//     // Now, you can add new notes to the category's notes list
//     final newNotes = await _categoryService.getNotes(ownerUserId: ownerUserId);
//     await _categoryService.getCategories(ownerUserId: ownerUserId);
//     // Check if there are new notes to add to the category
//     if (newNotes.isNotEmpty) {
//       // Update the category's notes list with the new notes
//       newCategory.notes.addAll(newNotes);

//       // Update the category in Firestore with the updated notes list
//       await _categoryService.updateListCategory(
//         documentId: newCategory.id,
//         categoryName: newCategory.name,
//         categoryNotes: newCategory.notes,
//       );
//     }

//     // Return the updated category
//     return newCategory;
//   }

//   void _titleControllerListener() async {
//     final category = _category;
//     if (category == null) {
//       return;
//     }

//     final title = _categoryNameController.text;
//     await _categoryService.updateListCategory(
//         documentId: category.id, categoryName: title, categoryNotes: []);
//   }

//   void _setUpTextControllerListener() {
//     _categoryNameController.removeListener(() {
//       _titleControllerListener;
//     });
//     _categoryNameController.addListener(() {
//       _titleControllerListener;
//     });
//   }

//   @override
//   dispose() {
//     _categoryNameController.dispose();
//     _titleControllerListener();
//     super.dispose();
//   }

//   Future<void> showCategoriesDialog(BuildContext context) async {
//     await showDialog(
//         context: (context),
//         builder: ((context) {
//           return Container(
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
//             child: AlertDialog(
//               title: const Text('Add a category'),
//               content: TextField(
//                 controller: _categoryNameController,
//                 decoration: const InputDecoration(
//                   contentPadding: EdgeInsets.all(6),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Color.fromARGB(255, 4, 94, 211), width: 1),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Color.fromARGB(255, 4, 94, 211), width: 1),
//                   ),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: (() async {
//                     await createCategory(context);
//                     Navigator.pop(context);
//                   }),
//                   child: const Text('Ok'),
//                 ),
//                 TextButton(
//                     onPressed: (() {
//                       Navigator.of(context).pop();
//                     }),
//                     child: const Text('Cancel'))
//               ],
//             ),
//           );
//         }));
//   }
//   // Future<CloudCategory> createCategory(BuildContext context) async {
//   //   final newCategory = await _categoryService.createCategory(
//   //     ownerUserId: categoryId,
//   //     // Use the entered category name
//   //   );

//   //   return newCategory;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Container(
//         height: 80,
//         width: 80,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(59),
//           color: const Color.fromARGB(255, 4, 94, 211),
//         ),
//         child: IconButton(
//             onPressed: (() async {
//               showCategoriesDialog(context);
//             }),
//             icon: const Icon(
//               Icons.post_add,
//               color: Colors.white,
//               size: 40,
//             )),
//       ),
//       body: StreamBuilder<List<CloudCategory>>(
//           stream: _categoryService.allCategories(ownerUserId: categoryId),
//           builder: (context, snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//               case ConnectionState.active:
//                 if (snapshot.hasData) {
//                   final allCategories = snapshot.data!;
//                   if (allCategories.isEmpty) {
//                     return Container(
//                       child: const Center(
//                         child: Text(
//                             'No Category Yet. Click the Icon below to add'),
//                       ),
//                     );
//                   } else {
//                     return Container(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             SizedBox(
//                               height: 70,
//                               child: IconButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   icon: const Icon(Icons.arrow_back_ios_new)),
//                             ),
//                             Text(
//                               'All Categories',
//                               style: GoogleFonts.nunito(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 30,
//                                   color: const Color.fromARGB(255, 88, 88, 88)),
//                             ),
//                             Expanded(
//                                 child: allCategories.isEmpty
//                                     ? Container(
//                                         child: const Center(
//                                             child: const Text(
//                                                 'No Category Yet. Click the Icon below to add')),
//                                       )
//                                     : InkWell(
//                                         onTap: (() {
//                                           Navigator.of(context)
//                                               .pushNamed(addCategoryNote);
//                                         }),
//                                         child: GridView.builder(
//                                             gridDelegate:
//                                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                                     crossAxisCount: 2,
//                                                     crossAxisSpacing: 5,
//                                                     mainAxisSpacing: 10,
//                                                     childAspectRatio: 1.2),
//                                             itemCount: allCategories.length,
//                                             itemBuilder: ((context, index) {
//                                               final category =
//                                                   allCategories[index];
//                                               return Container(
//                                                   margin: const EdgeInsets.only(
//                                                       right: 10),
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10),
//                                                       color: const Color
//                                                                   .fromARGB(
//                                                               255, 4, 94, 211)
//                                                           .withOpacity(0.2)),
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.end,
//                                                     children: [
//                                                       Center(
//                                                         child: Text(
//                                                           category.name,
//                                                           maxLines: 2,
//                                                           style: GoogleFonts
//                                                               .nunito(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontSize: 20,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 20),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .end,
//                                                         children: [
//                                                           IconButton(
//                                                               onPressed:
//                                                                   (() {}),
//                                                               icon: Icon(
//                                                                   Icons.delete))
//                                                         ],
//                                                       )
//                                                     ],
//                                                   ));
//                                             })),
//                                       )),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }

//               default:
//                 return const Center(child: CircularProgressIndicator());
//             }
//           }),
//     );
//   }
// }
