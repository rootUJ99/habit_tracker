import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habbit_tracker/provider/habit_provider.dart';
import 'package:habbit_tracker/routes.dart';
import 'package:habbit_tracker/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:habbit_tracker/push_notification_handler.dart';
import 'package:habbit_tracker/stateful_wrapper.dart';
// import 'package:timezone/data/latest_all.dart';

final ColorScheme kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 40, 54, 122));

final ColorScheme kColorSchemeDark = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 42, 48, 76));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalPushNotification.configureLocalTimeZone();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Habits()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        LocalPushNotification();
        // LocalPushNotification.initialize();
      },
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Habit Tracker',
        darkTheme: ThemeData(colorScheme: kColorSchemeDark, useMaterial3: true),
        theme: ThemeData(colorScheme: kColorScheme, useMaterial3: true),
      ),
    );
  }
}
