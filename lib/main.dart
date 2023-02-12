import 'package:ai_art/mainscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
const bgcolor = Color(0xff191919);
const btncolor = Color(0xff6B4FD8);
const whitecolor = Colors.white;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: mainScreen(),
    );
  }
}
