import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/drawer_icon.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/pages/menu/menu_controller.dart';
import 'package:sigma/pages/menu/menu_page.dart';

import '../../helper/strings.dart';

class AdvertiseMenu extends StatelessWidget {
  AdvertiseMenu({super.key});


  // تغییر منو هنگام لود شدن صفحه

  @override
  Widget build(BuildContext context) {

    Get.find<MenuControllerDefault>().setMenuItems([drawerIcon(path: 'assets/advretise.svg', route: RouteName.advertise,isItsSize: true), drawerIcon(path: 'assets/stocks.svg', route: RouteName.stocks,isItsSize: true)]);
    return ParentMenuWidget(child: Center(), title: Strings.advertises);
  }
}
