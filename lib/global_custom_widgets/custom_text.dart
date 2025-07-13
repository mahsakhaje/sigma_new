import 'package:flutter/material.dart';

Widget CustomText(String txt,
    {int? maxLine,
      Color color = Colors.white,
      double size = 12,
      bool isRtl = false,
      TextAlign? textAlign,
      FontStyle style = FontStyle.normal,
      FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    txt,
    textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
    maxLines: maxLine == null ? 100 : maxLine,
    textAlign: textAlign,
    locale: Locale('fa'),
    style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        fontStyle: style,
        fontFamily: "Peyda"),
  );
}
