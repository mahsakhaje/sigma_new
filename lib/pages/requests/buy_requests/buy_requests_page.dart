import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/global_custom_widgets/requests_item.dart';
import 'package:sigma/models/my_purchase_order_response.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

import 'buy_requests_controller.dart';

class MyBuyOrdersPage extends StatelessWidget {
  const MyBuyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyBuyOrdersController());

    return DarkBackgroundWidget(
      title: 'سفارشات خرید',
      child:  Obx(() {
          if (controller.isLoading.value) {
            return  Center(
              child: CustomText('در حال دریافت اطلاعات'),
            );
          }

          if (controller.purchaseOrders.isEmpty) {
            return  NoContent();
          }

          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.hasMore.value
                ? controller.purchaseOrders.length + 1
                : controller.purchaseOrders.length,
            itemBuilder: (context, index) {
              if (index == controller.purchaseOrders.length && controller.hasMore.value) {
                return  Center(
                  child: loading(),
                );
              }

              final order = controller.purchaseOrders[index];
              return RequestCard(
                trackingCode: order.id ?? '',
                status: order.stateText??"", // You'll need to implement this
                carName: order.brandDescription ?? '',
                carModel: order.carModelDescription ?? '',
                carEngine: order.carTypeDescription ?? '',
                carColor: order.colorDescription??"", // Add this field to PurchaseOrders if needed
                carYear: (order.toManufactureYear??'')+'-'+(order.fromMileage??""), // Add this field to PurchaseOrders if needed
                onProposalsPressed: () => controller.onProposalsPressed(order),
              );
            },
          );
        }),

    );
  }

  // Helper method to determine order status
  String _getOrderStatus(PurchaseOrders order) {
    // Implement your status logic based on the order properties
    // This is just an example
    return 'فعال'; // or whatever status logic you need
  }
}