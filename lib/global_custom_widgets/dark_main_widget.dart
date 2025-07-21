import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/menu/menu_controller.dart';

class DarkBackgroundWidget extends StatelessWidget {
  final Widget child;
  final String title;

  const DarkBackgroundWidget({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        backgroundColor: AppColors.darkGrey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CustomText(Strings.returnn,
                          color: Colors.black, fontWeight: FontWeight.bold)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: CustomText(title,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    size: 14),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      CustomText(Strings.close,
                          color: Colors.black, fontWeight: FontWeight.bold),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.close_outlined,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              // Background image
              SizedBox.expand(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/dark_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              child,
            ],
          ),
        ),
      ),
    );
  }
}
