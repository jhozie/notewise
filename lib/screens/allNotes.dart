// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:notewise/screens/note_list.dart';
// import 'package:notewise/services/auth/auth_service.dart';
// import 'package:notewise/services/cloud/cloud_category.dart';
// import 'package:notewise/services/cloud/cloud_note.dart';
// import 'package:notewise/services/cloud/firebase_cloud_note.dart';
// import 'package:notewise/utilities/get_argument.dart';
// import 'package:notewise/utilities/grid_container.dart';
// import 'package:notewise/utilities/showdialog.dart';

// import '../Route/route.dart';

// class Categories extends StatefulWidget {
//   const Categories({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Categories> createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> {
//   CloudCategory? _category;
//   late TextEditingController _categoryNameController;
//   late FireBaseCloudStorage _noteService;
//   final categoryId = AuthService.firebase().currentUser!.id;
//   var _selectedIndex = 0;

//   @override
//   void initState() {
//     _noteService = FireBaseCloudStorage();
//     _categoryNameController = TextEditingController();

//     super.initState();
//   }

//   Future<CloudCategory> createNote(BuildContext context) async {
//     final widgetcategory = context.getArgument<CloudCategory>();

//     if (widgetcategory != null) {
//       _category = widgetcategory;
//       _categoryNameController.text = widgetcategory.name;
//       return widgetcategory;
//     }
//     final existingCategory = _category;
//     if (existingCategory != null) {
//       return existingCategory;
//     }
//     final currentUser = AuthService.firebase().currentUser!;
//     final ownerUserId = currentUser.id;
//     final newCategory = await _noteService.createCategory(
//       ownerUserId: ownerUserId,
//     );

//     _category = newCategory;
//     return newCategory;
//   }

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
//               await showCategoriesDialog(context, _categoryNameController);
//             }),
//             icon: const Icon(
//               Icons.post_add,
//               color: Colors.white,
//               size: 40,
//             )),
//       ),
//       body: StreamBuilder<List<CloudCategory>>(
//           stream: _noteService.allCategories(ownerUserId: categoryId),
//           builder: (context, snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//               case ConnectionState.active:
//                 if (snapshot.hasData) {
//                   final allCategories = snapshot.data!;

//                   return Container(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           SizedBox(
//                               height: 70,
//                               child: IconButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   icon: const Icon(Icons.arrow_back_ios_new))),
//                           Text(
//                             'All Notes',
//                             style: GoogleFonts.nunito(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 30,
//                                 color: const Color.fromARGB(255, 88, 88, 88)),
//                           ),
//                           Expanded(child:
//                               ListView.builder(itemBuilder: ((context, index) {
//                             final category = allCategories.elementAt(index);
//                             return Container(
//                               width: 20,
//                               height: 20,
//                               child: Text(category.name),
//                             );
//                           }))),
//                         ],
//                       ),
//                     ),
//                   );
//                 } else {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//               default:
//                 return const Center(child: CircularProgressIndicator());
//             }
//           }),
//       bottomNavigationBar: Container(
//         child: BottomNavigationBar(
//           iconSize: 30,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: IconButton(
//                     onPressed: (() {
//                       Navigator.of(context).pushNamed(note);
//                     }),
//                     icon: Icon(Icons.home_filled)),
//                 label: 'Home'),
//             BottomNavigationBarItem(
//                 icon: IconButton(
//                     onPressed: (() {
//                       Navigator.of(context).pushNamed(categories);
//                     }),
//                     icon: Icon(Icons.notes_outlined)),
//                 label: 'Categories'),
//             BottomNavigationBarItem(
//                 icon: IconButton(
//                     onPressed: (() {
//                       Navigator.of(context).pushNamed(settings);
//                     }),
//                     icon: Icon(Icons.settings_outlined)),
//                 label: 'Settings'),
//           ],
//           currentIndex: _selectedIndex,
//         ),
//       ),
//     );
//   }
// }

// class CategoryView extends StatefulWidget {
//   final List<CloudCategory> categories;
//   final TextEditingController cate;
//   const CategoryView({super.key, required this.categories, required this.cate});

//   @override
//   State<CategoryView> createState() => _CategoryViewState();
// }

// class _CategoryViewState extends State<CategoryView> {
//   late TextEditingController _categoryNameController;
//   CloudCategory? _category;
//   late FireBaseCloudStorage _noteService;

//   @override
//   void initState() {
//     _noteService = FireBaseCloudStorage();
//     _categoryNameController = TextEditingController();
//     super.initState();
//   }

//   Future<CloudCategory> createNote(BuildContext context) async {
//     final widgetcategory = context.getArgument<CloudCategory>();

//     if (widgetcategory != null) {
//       _category = widgetcategory;
//       _categoryNameController.text = widgetcategory.name;
//       return widgetcategory;
//     }
//     final existingCategory = _category;
//     if (existingCategory != null) {
//       return existingCategory;
//     }
//     final currentUser = AuthService.firebase().currentUser!;
//     final ownerUserId = currentUser.id;
//     final newCategory = await _noteService.createCategory(
//       ownerUserId: ownerUserId,
//     );

//     _category = newCategory;
//     return newCategory;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(itemBuilder: ((context, index) {
//       final category = widget.categories.elementAt(index);
//       return Container(
//         width: 20,
//         height: 20,
//         child: Text(category.name),
//       );
//     }));
//   }
// }
