import 'package:flutter/material.dart';

import 'custom_text.dart' show CustomText;

Widget customOutlinedButton(void Function()? onPressed, String title,
    {Color borderColorolor = Colors.white, Color txtColor = Colors.white}) {
  return Row(
    children: [
      Expanded(
        child: OutlinedButton(
          onPressed: onPressed,
          child: CustomText(title,
              size: 14, fontWeight: FontWeight.bold, color: txtColor),
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1.0, color: borderColorolor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(width: 5.0, color: borderColorolor),
            ),
            minimumSize: Size(254, 60),
          ),
        ),
      ),
    ],
  );
}
