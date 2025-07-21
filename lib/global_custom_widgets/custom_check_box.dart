import 'package:flutter/material.dart';
import 'package:sigma/helper/colors.dart';

Widget CustomCheckBox(
    {required bool value,
    required ValueChanged<bool?>? onChanged,
    bool isDark = false,
    bool isBlue = false}) {
  return Checkbox(
      activeColor: isBlue ? AppColors.blue : Colors.transparent,
      value: value,
      side: BorderSide(
        // set border color here
        color: isDark ? Colors.black87 : Colors.white,
      ),
      onChanged: (value) {
        onChanged?.call(value);
      });
}
