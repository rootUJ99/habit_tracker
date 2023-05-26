import 'package:flutter/foundation.dart';

class Habits with ChangeNotifier, DiagnosticableTreeMixin {
  // Map<String, String>_habit = {

  // }
  final List<Map<String, String>> _habits = [];

  List<Map<String, String>> get habits => _habits;

  void addHabit(Map<String, String> item) {
    _habits.add(item);
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('count', count));
  // }
}
