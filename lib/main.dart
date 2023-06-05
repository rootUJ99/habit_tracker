import 'package:flutter/material.dart';
import 'package:habbit_tracker/provider/habit_provider.dart';
import 'package:habbit_tracker/routes.dart';
import 'package:habbit_tracker/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Habits()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 40, 54, 122),
          useMaterial3: true),
    );
  }
}
