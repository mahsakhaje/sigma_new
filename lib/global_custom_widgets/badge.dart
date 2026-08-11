import 'package:flutter/material.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';

Widget badge(String status, {Color? color}) {
  return status.length > 1
      ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: color != null ? Colors.transparent : AppColors.darkGrey,
            border: Border.all(color:color != null ? color : Colors.transparent ) ,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomText(status,
              color: color != null ? color : AppColors.orange,
              fontWeight: FontWeight.bold,
              isRtl: true),
        )
      : SizedBox();
}
