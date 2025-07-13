import 'package:flutter/material.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/helper.dart';

Widget detailItem(String info, String title, {bool isRtl = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
          child: CustomText(info.usePersianNumbers(),
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              maxLine: 4,
              isRtl: isRtl)),
      SizedBox(
        width: 8,
      ),
      CustomText(title.usePersianNumbers(),
          color: Colors.black87, fontWeight: FontWeight.w500)
    ],
  );
}