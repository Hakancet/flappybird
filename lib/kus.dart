import 'package:flutter/material.dart';

class benimkus extends StatefulWidget {
  const benimkus({Key? key}) : super(key: key);

  @override
  State<benimkus> createState() => _benimkusState();
}

class _benimkusState extends State<benimkus> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6,
      width: 6,
      child: Image.asset('assets/images/polatyanpix.png'),
    );
  }
}
