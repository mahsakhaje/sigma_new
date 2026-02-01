import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/drawer_icon.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/pages/menu/menu_controller.dart';
import 'package:sigma/pages/menu/menu_page.dart';

import '../../helper/strings.dart';

class GuideMenuPage extends StatelessWidget {
  GuideMenuPage({super.key});

  // تغییر منو هنگام لود شدن صفحه

  @override
  Widget build(BuildContext context) {
    Get.find<MenuControllerDefault>().setMenuItems([
      drawerIcon(
          path: 'assets/about_us.svg', route: RouteName.about, isItsSize: true),
      // drawerIcon(
      //     path: 'assets/questions.svg',
      //     route: RouteName.),
      drawerIcon(
          path: 'assets/frequent.svg',
          route: RouteName.questions,
          isItsSize: true),
      drawerIcon(
          path: 'assets/ghavanin.svg', route: RouteName.rules, isItsSize: true),
      drawerIcon(
          path: 'assets/contact_us.svg',
          route: RouteName.contactus,
          isItsSize: true),
    ]);
    return ParentMenuWidget(child: Center(), title: Strings.guide);
  }
}
