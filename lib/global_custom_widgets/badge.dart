import 'package:flutter/material.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';

Widget badge(String status,{Color? color}) {
  return status.length > 1
      ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.darkGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomText(status,
              color:color !=null? color: AppColors.orange,
              fontWeight: FontWeight.bold,
              isRtl: true),
        )
      : SizedBox();
}
