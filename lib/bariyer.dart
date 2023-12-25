import 'package:flutter/material.dart';

class bariyer extends StatelessWidget {
  final size;

  bariyer({this.size});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 10 , color: Colors.green.shade800),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
