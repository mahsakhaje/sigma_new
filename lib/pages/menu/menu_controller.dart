import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuControllerDefault extends GetxController {
  var menuItems = <Widget>[].obs;
  var isOpen = false.obs;

  @override
  void onInit() async {
    super.onInit();;
  }

  void toggle() => isOpen.value = !isOpen.value;

  void close() => isOpen.value = false;

  void open() => isOpen.value = true;

  void setMenuItems(List<Widget> items) {
    menuItems.value = items;
  }
}
