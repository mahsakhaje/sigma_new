import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/drawer_icon.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/pages/menu/menu_controller.dart';
import 'package:sigma/pages/menu/menu_page.dart';
import 'package:sigma/pages/technical_menu/technicalInfro_controller.dart';

import '../../helper/strings.dart';

class TechnicalMenu extends StatelessWidget {
  TechnicalMenu({super.key});

  // تغییر منو هنگام لود شدن صفحه

  @override
  Widget build(BuildContext context) {
    Get.find<MenuControllerDefault>().setMenuItems([
      drawerIcon(
          path: 'assets/technical_info.svg',
          route: RouteName.technicalInfo,
          arg: technicalPageState.info,
          isItsSize: true),
      drawerIcon(
          path: 'assets/compare_car.svg',
          route: RouteName.technicalInfo,
          arg: technicalPageState.compare,
          isItsSize: true),
      drawerIcon(
          path: 'assets/price_chart.svg',
          route: RouteName.technicalInfo,
          arg: technicalPageState.pricheChart,
          isItsSize: true)
    ]);
    return ParentMenuWidget(child: Center(), title: Strings.carInfo);
  }
}
