import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/push_notification_handler.dart';

typedef DynamicMap = Map<String, dynamic>;

class Habits with ChangeNotifier, DiagnosticableTreeMixin {
  // Map<String, String>_habit = {

  // }
  final List<DynamicMap> _habits = [];

  List<DynamicMap> get habits => _habits;

  List<int>? _notificationIds = [];

  int _generateRandomId() {
    int randomId = Random().nextInt(500);
    if (_notificationIds!.contains(randomId)) {
      _generateRandomId();
    }
    return randomId;
  }

  void setNotificationIds(List<int>? inputNotificationListIds) {
    _notificationIds = inputNotificationListIds;
  }

  void addHabit(DynamicMap item, CollectionReference habitCol) {
    int intId = _generateRandomId();
    habitCol.doc(item['id']).set({
      ...item,
      'intId': intId,
      'repeatTime': item['repeatTime'].toString(),
      'repeatTimeWithHourMin': item['repeatTimeWithHourMin'].toString(),
    }).then((value) {
      // _habits.add(item);
      LocalPushNotification pushNoti = LocalPushNotification();
      pushNoti.scheduleDailyNotification(
          intId: intId,
          header: item['name'],
          body: item['description'],
          hour: item['repeatTimeWithHourMin']!.hour,
          min: item['repeatTimeWithHourMin']!.minute);
      notifyListeners();
    }).catchError((err) => print(err));
    // _habits.add(item);
  }

  void updateHabit(DynamicMap item, CollectionReference habitCol) {
    LocalPushNotification pushNoti = LocalPushNotification();
    habitCol.doc(item['id']).set({
      ...item,
      'repeatTime': item['repeatTime'].toString(),
      'repeatTimeWithHourMin': item['repeatTimeWithHourMin'].toString(),
    }).then((value) {
      pushNoti.cancelNotification(intId: item['intId']);
      pushNoti.scheduleDailyNotification(
          intId: item['intId'],
          header: item['name'],
          body: item['description'],
          hour: item['repeatTimeWithHourMin']!.hour,
          min: item['repeatTimeWithHourMin']!.minute);

      notifyListeners();
    }).catchError((err) => print(err));

    // int index = _habits.indexWhere((element) => element['id'] == item['id']);
    // _habits.removeAt(index);
    // _habits.insert(index, item);
  }

  void deleteHabit(
      DynamicMap item, CollectionReference habitCol, Function callback) {
    LocalPushNotification pushNoti = LocalPushNotification();
    habitCol.doc(item['id']).delete().then((value) {
      notifyListeners();
      pushNoti.cancelNotification(intId: item['intId']);
      callback();
    }).catchError((err) => print(err));
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('count', count));
  // }
}
