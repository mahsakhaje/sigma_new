import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/requests_item.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/pages/requests/showrooms_requests/showroom_reservations_controller.dart';

class MyReservationsPage extends StatelessWidget {
  const MyReservationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyReservationsController());

    return DarkBackgroundWidget(
      title: 'رزروهای شوروم',
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CustomText('در حال دریافت اطلاعات'),
          );
        }

        if (controller.reservations.isEmpty) {
          return Center(
            child: CustomText('موردی یافت نشد'),
          );
        }

        return ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.hasMore.value
              ? controller.reservations.length + 1
              : controller.reservations.length,
          itemBuilder: (context, index) {
            if (index == controller.reservations.length &&
                controller.hasMore.value) {
              return Center(
                child: loading(),
              );
            }

            final order = controller.reservations[index];
            return RequestCard(
              trackingCode: order.id ?? '',
              status: order.reservationStateText ?? "",
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
