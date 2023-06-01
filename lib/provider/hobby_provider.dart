import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

typedef DynamicMap = Map<String, dynamic>;

class Habits with ChangeNotifier, DiagnosticableTreeMixin {
  // Map<String, String>_habit = {

  // }
  final List<DynamicMap> _habits = [];

  List<DynamicMap> get habits => _habits;

  void addHabit(DynamicMap item, CollectionReference habitCol) {
    habitCol.doc(item['id']).set(
        {...item, 'repeatTime': item['repeatTime'].toString()}).then((value) {
      _habits.add(item);
      notifyListeners();
    }).catchError((err) => print(err));
    // _habits.add(item);
  }

  void updateHabit(DynamicMap item, CollectionReference habitCol) {
    habitCol
        .doc(item['id'])
        .set({...item, 'repeatTime': item['repeatTime'].toString()})
        .then((value) {})
        .catchError((err) => print(err));

    int index = _habits.indexWhere((element) => element['id'] == item['id']);
    _habits.removeAt(index);
    _habits.insert(index, item);
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('count', count));
  // }
}
