// import 'package:flutter/material.dart';
// import 'package:notewise/services/cloud/cloud_note.dart';

// class MySearchField extends StatefulWidget {
//   MySearchField({Key? key, required this.notes}) : super(key: key);

//   final List<CloudNote> notes;

//   @override
//   State<MySearchField> createState() => _MySearchFieldState();
// }

// class _MySearchFieldState extends State<MySearchField> {
//   List<CloudNote> searchedNotes = [];

//   @override
//   Widget build(BuildContext context) {
//     void searchedNote(String search) {
//       setState(() {
//         searchedNotes = widget.notes
//             .where((notes) =>
//                 notes.title.toLowerCase().contains(search.toLowerCase()))
//             .toList();
//       });
//     }

//     return TextField(
//       onChanged: (value) => searchedNote(value),
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.search),
//         contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
//         labelText: 'label',
//         hintText: 'hint',
//         border: const OutlineInputBorder(
//           borderSide:
//               BorderSide(color: Color.fromARGB(255, 4, 94, 211), width: 2),
//           borderRadius: BorderRadius.all(Radius.circular(30)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               color: const Color.fromARGB(255, 4, 94, 211).withOpacity(0.2),
//               width: 2),
//           borderRadius: const BorderRadius.all(Radius.circular(30)),
//         ),
//       ),
//     );
//   }
// }
