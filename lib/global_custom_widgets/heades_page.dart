import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';

class HeadedPage extends StatelessWidget {
  Widget child;
  String title;
  bool hideAppBar;

  HeadedPage(
      {super.key,
      required this.child,
      required this.title,
      this.hideAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.darkGrey,
      appBar: hideAppBar
          ? null
          : AppBar(
              title: CustomText(title),
            ),
      body: kIsWeb
          ? child
          : KeyboardDismissOnTap(dismissOnCapturedTaps: true, child: child),
    );
  }
}
