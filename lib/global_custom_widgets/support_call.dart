import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

Widget SupportCall(String supportNumber){
  return InkWell(
    onTap: () async {
      if (supportNumber.isNotEmpty) {
        supportNumber=refactorSupportNumber(supportNumber);
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: supportNumber,
        );
        await launchUrl(launchUri);
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8, horizontal: 2),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          // SvgPicture.asset(
          //   'assets/edit.svg',
          //   color: Colors.white,
          // ),
          SvgPicture.asset(
            'assets/support.svg',
          ),
          CustomText('پشتیبانی', size: 16),
        ],
      ),
    ),
  );
}

String refactorSupportNumber(String supportNumber) {

  if(supportNumber.contains('-')){
    final numbers=supportNumber.split('-');
    for (var a in numbers){
      if(a.trim().startsWith('09')){
        supportNumber=a;
      }
    }
  }
  return supportNumber;
}