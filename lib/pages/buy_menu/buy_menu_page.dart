import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/drawer_icon.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/pages/menu/menu_controller.dart';
import 'package:sigma/pages/menu/menu_page.dart';

import '../../helper/strings.dart';

enum BuyState { USED, NEW, NORMAL }

class BuyMenuPage extends StatelessWidget {
  BuyMenuPage({super.key});

  // تغییر منو هنگام لود شدن صفحه

  @override
  Widget build(BuildContext context) {
    Get.find<MenuControllerDefault>().setMenuItems([
      drawerIcon(path: 'assets/buy_new.svg', route: RouteName.buy, arg: BuyState.NEW.name),
      drawerIcon(
          path: 'assets/buy_used.svg', route: RouteName.buy, arg: BuyState.USED.name),
      drawerIcon(
          path: 'assets/buy_order.svg', route: RouteName.buy, arg: BuyState.NORMAL.name),
      drawerIcon(path: 'assets/loan.svg', route: RouteName.loan)
    ]);
    return ParentMenuWidget(child: Center(), title: Strings.buyCar);
  }
}
