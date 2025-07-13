import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/global_custom_widgets/requests_item.dart';
import 'sales_orders_controller.dart';

class MySalesOrdersPage extends StatelessWidget {
  const MySalesOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MySalesOrdersController());

    return DarkBackgroundWidget(
      title: 'درخواست های فروش',
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CustomText('در حال دریافت اطلاعات'),
          );
        }

        if (controller.salesOrders.isEmpty) {
          return NoContent();
        }

        return ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.hasMore.value
              ? controller.salesOrders.length + 1
              : controller.salesOrders.length,
          itemBuilder: (context, index) {
            if (index == controller.salesOrders.length &&
                controller.hasMore.value) {
              return Center(
                child: loading(),
              );
            }

            final order = controller.salesOrders[index];
            return RequestCard(
              trackingCode: order.id ?? '',
              status: order.stateText ?? "",
              // You'll need to implement this
              carName: order.brandDescription ?? '',
              carModel: order.carModelDescription ?? '',
              carEngine: order.carTypeDescription ?? '',
              carColor: order.colorDescription ?? "",
              // Add this field to PurchaseOrders if needed
              carYear: order.persianYear ?? "",
              // Add this field to PurchaseOrders if needed
              onProposalsPressed: () => controller.onProposalsPressed(order),
            );
          },
        );
      }),
    );
  }
}
