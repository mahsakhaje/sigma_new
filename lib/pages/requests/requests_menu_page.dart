import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/drawer_icon.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/pages/menu/menu_controller.dart';
import 'package:sigma/pages/menu/menu_page.dart';

import '../../helper/strings.dart';

class RequestsMenuPage extends StatelessWidget {
  RequestsMenuPage({super.key});


  @override
  Widget build(BuildContext context) {
    Get.find<MenuControllerDefault>().setMenuItems([
      drawerIcon(
          path: 'assets/buy_requests.svg', route: RouteName.myBuyRequests),
      drawerIcon(
          path: 'assets/sell_requests.svg', route: RouteName.mySalesOrder),
      drawerIcon(
          path: 'assets/reserve_showroom.svg', route: RouteName.myShowRooms)
    ]);
    return ParentMenuWidget(child: Center(), title: Strings.requests);
  }
}
