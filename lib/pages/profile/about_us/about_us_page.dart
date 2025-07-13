import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart' show HtmlWidget;
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/profile/about_us/about_us_controller.dart';
import 'package:universal_platform/universal_platform.dart' show UniversalPlatform;

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);

  final AboutUsController controller = Get.put(AboutUsController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: Strings.aboutUs,
      child:  Obx(() => ListView(
          padding: EdgeInsets.all(16),
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: HtmlWidget(
                controller.aboutUs.value,
                customStylesBuilder: (element) {
                  return {
                    'text-align': UniversalPlatform.isWeb ? 'right' : 'justify',
                  };
                },
                textStyle: TextStyle(color: Colors.white,fontFamily: 'Peyda'),
              ),
            ),
          ],
        )),

    );
  }
}