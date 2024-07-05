import 'package:flutter/material.dart';
import 'package:student_crud_sqlflite/SQLDB.dart';
import 'package:student_crud_sqlflite/addStudent.dart';
import 'package:student_crud_sqlflite/home.dart';

Future<void> main() async {
  SQLdb sqLdb = SQLdb();
  await WidgetsFlutterBinding.ensureInitialized();
  await sqLdb.initialisation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.orange),
      home: HomeMain(),
      routes: {
        "addStudent": (context) => AddStudent(),
      },
    );
  }
}
