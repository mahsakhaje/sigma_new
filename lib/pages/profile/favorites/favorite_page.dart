import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/car_item.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/profile/favorites/favorite_controller.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class FavoritesPage extends StatelessWidget {
  final FavoritesController controller = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: Strings.favorites,
      child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: loading());
          } else if (controller.orders.isEmpty) {
            return NoContent();
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: controller.orders.length,
              itemBuilder: (ctx, index) {
                final order = controller.orders[index];
                return carItem(
                  context,
                  order,
                      () => controller.delete(order.id ?? ""),
                  isFavorite: true,
                );
              },
            );
          }
        }),

    );
  }
}
