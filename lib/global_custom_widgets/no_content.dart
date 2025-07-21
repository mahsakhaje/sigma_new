import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';

Widget NoContent(){
  return Center(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CustomText('موردی یافت نشد!', isRtl: true,size: 16),
      Padding(
        padding: const EdgeInsets.all(22.0),
        child: SvgPicture.asset('assets/empty.svg'),
      )

    ],
  ));
}