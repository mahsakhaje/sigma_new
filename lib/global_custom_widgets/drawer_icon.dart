import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/outlined_button.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/storage_helper.dart';
import 'package:sigma/models/global_app_data.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawerIcon(
    {required String path, required String route, String arg = ''}) {
  return InkWell(
    onTap: () async {
      if (route == 'exit') {
        await logOut();
        return;
      }
      if (route == RouteName.chat) {
        launchUrl(Uri.parse('https://www.goftino.com/c/j2kPkF'),
            mode: LaunchMode.inAppWebView);
        return;
      }
      if (route == RouteName.social) {
        CustomBottomSheet.show(
            context: Get.context!,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(GlobalAppData().aparat),
                              mode: LaunchMode.platformDefault);
                        },
                        child: SvgPicture.asset('assets/aparat.svg'),
                      )),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          print(GlobalAppData().telegram);
                          launchUrl(Uri.parse(GlobalAppData().telegram),
                              mode: LaunchMode.platformDefault);
                        },
                        child: SvgPicture.asset('assets/telegram.svg'),
                      )),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(GlobalAppData().insta));
                        },
                        child: SvgPicture.asset('assets/instagram.svg'),
                      )),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(GlobalAppData().linkedin));
                        },
                        child: SvgPicture.asset('assets/linkedin.svg'),
                      )),
                    ],
                  ),
                ),
              ],
            ),
            initialChildSize: 0.20);
        return;
      }
      Get.toNamed(route, arguments: arg);
    },
    child: SvgPicture.asset(path,fit: BoxFit.fill,),
  );
}

Future<void> logOut() async {
  bool? shouldLogOut = await CustomBottomSheet.show(
    context: Get.context!,
    initialChildSize: 0.3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 22,
        ),
        CustomText('آیا مایل به خروج از حساب کاربری خود هستید؟',
            color: Colors.black87,
            isRtl: true,
            size: 15,
            fontWeight: FontWeight.bold),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: customOutlinedButton(() {
                    Get.back(result: false);
                  }, 'انصراف',
                      txtColor: Colors.black87, borderColorolor: Colors.red),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: ConfirmButton(
                  () async {
                    Get.back(result: true);
                  },
                  'تایید',
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );

  if (shouldLogOut ?? false) {
    StorageHelper().setIsLogedIn(false);
    StorageHelper().setPhoneNumber('');
    StorageHelper().setShortToken('');
    Get.back();
    Get.offAllNamed(RouteName.auth);
  }
}
