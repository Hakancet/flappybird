import 'package:flappybird/Splash.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const Mybird());
}

class Mybird extends StatefulWidget {
  const Mybird({Key? key}) : super(key: key);

  @override
  State<Mybird> createState() => _MybirdState();
}

class _MybirdState extends State<Mybird> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashPage(),
    );
  }
}
