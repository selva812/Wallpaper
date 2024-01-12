import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget {
  final String name1;
  final String name2;
  const Customappbar({super.key, required this.name1, required this.name2});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: name1,
            style: const TextStyle(color: Colors.black, fontSize: 20)),
        TextSpan(
            text: name2,
            style: const TextStyle(color: Colors.orange, fontSize: 20))
      ]),
    );
  }
}
