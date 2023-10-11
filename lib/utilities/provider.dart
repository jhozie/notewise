import 'package:flutter/material.dart';
import '../services/cloud/cloud_note.dart';

class LatestListProvider extends ChangeNotifier {
  List<CloudNote> _latestList = [];

  List<CloudNote> get latestList => _latestList;

  void addToLatestList(CloudNote note) {
    _latestList.add(note);
    notifyListeners();
  }

  void removeFromLatestList(int index) {
    _latestList.removeAt(index);
    notifyListeners();
  }
}
