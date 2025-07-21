import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/drawer_icon.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/pages/menu/menu_controller.dart';
import 'package:sigma/pages/menu/menu_page.dart';

import '../../helper/strings.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});


  // تغییر منو هنگام لود شدن صفحه

  @override
  Widget build(BuildContext context) {

    Get.find<MenuControllerDefault>().setMenuItems([drawerIcon(path: 'assets/edit_profile.svg', route: RouteName.editProfile), drawerIcon(path: 'assets/favorites.svg', route: RouteName.favourites), drawerIcon(path: 'assets/my_cars.svg', route: RouteName.myCars), drawerIcon(path: 'assets/suggestions.svg', route: RouteName.suggestions)]);
    return ParentMenuWidget(child: Center(), title: Strings.profile);
  }
}
