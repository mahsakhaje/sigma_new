import 'package:flutter/material.dart';

Widget dualRow(Widget first, Widget second) {
  return Row(
    children: [
      Expanded(child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: second,
      )),
      const SizedBox(
        width: 10,
      ),
      Expanded(child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: first,
      ))
    ],
  );
}