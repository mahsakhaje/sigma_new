import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/menu/menu_controller.dart';

class ParentMenuWidget extends StatelessWidget {
  final Widget child;
  final String title;

  const ParentMenuWidget({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath = title == Strings.buyCar
        ? 'assets/menue_bg.png'
        : title == Strings.requests
            ? 'assets/requestbg.png'
            : 'assets/profilebg.png';

    final menuController = Get.find<MenuControllerDefault>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 700));
      menuController.open();
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CustomText(Strings.returnn,
                        color: Colors.black, fontWeight: FontWeight.bold)
                  ],
                ),
              ),
            ),
            Expanded(
              child: CustomText(title,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  size: 14),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    CustomText(Strings.close,
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.close_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          // Add 1-second delay before toggling the drawer
          menuController.toggle();
        },
        child: Stack(
          children: [
            // Background image
            SizedBox.expand(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Drawer (side panel)
            Obx(() => AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  top: 0,
                  // below app bar
                  left: menuController.isOpen.value ? 0 : -120,
                  bottom: 0,
                  child: Container(
                    width: 100,
                    color: AppColors.lightGrey,
                    child: ListView(
                      children: menuController.menuItems
                          .map((item) => InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: item,
                                ),
                                onTap: () {
                                  menuController.close();
                                  // handle tap logic here
                                },
                              ))
                          .toList(),
                    ),
                  ),
                )),

            // Main content
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(left: 0),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
