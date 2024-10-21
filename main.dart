import 'package:flutter/material.dart';
import 'package:sqflit/addnote.dart';
import 'package:sqflit/edit.dart';
import 'package:sqflit/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      routes: {
        'addnotes': (context) => const Addnotes(),
        'home': (context) => const Home(),
        'edit': (context) => const Edit(),

      },
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
              color: Colors.yellow,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black))),
    );
  }
}
