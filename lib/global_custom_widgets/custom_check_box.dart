import 'package:flutter/material.dart';

Widget CustomCheckBox(
    {required bool value, required ValueChanged<bool?>? onChanged,bool isDark=false}) {
  return Checkbox(
    activeColor: Colors.transparent,
      value: value,
      side: BorderSide(
        // set border color here
        color: isDark ? Colors.black87: Colors.white,
      ),
      onChanged: (value) {
        onChanged?.call(value);
      });
}
