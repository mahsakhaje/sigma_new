import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/global_custom_widgets/requests_item.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/pages/my_cars/my_cars_controller.dart';

class MyCarsPage extends StatelessWidget {
  const MyCarsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyCarsController());

    return DarkBackgroundWidget(
      title: 'خودروهای من',
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: loading(),
          );
        }

        if (controller.cars.isEmpty) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            NoContent(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 26.0, vertical: 10),
              child: ConfirmButton(() async{
                await Get.toNamed(RouteName.car);
                controller.pn.value=0;
                controller.getData();
              }, 'افزودن خودرو'),
            )
          ]);
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.hasMore.value
                    ? controller.cars.length + 1
                    : controller.cars.length,
                itemBuilder: (context, index) {
                  if (index == controller.cars.length &&
                      controller.hasMore.value) {
                    return Center(
                      child: loading(),
                    );
                  }

                  final order = controller.cars[index];
                  return RequestCard(
                    trackingCode: order.chassisNumber ?? '',
                    status: "",
                    // You'll need to implement this
                    carName: order.brandDescription ?? '',
                    carModel: order.carModelDescription ?? '',
                    carEngine: order.carTypeDescription ?? '',
                    carColor: order.colorDescription ?? "",
                    // Add this field to PurchaseOrders if needed
                    carYear: (order.persianYear ?? ''),
                    // Add this field to PurchaseOrders if needed
                    onProposalsPressed: () =>
                        controller.onProposalsPressed(order),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 26.0, vertical: 10),
              child: ConfirmButton(() async{
                await Get.toNamed(RouteName.car);
                controller.pn.value=0;
                controller.getData();
              }, 'افزودن خودرو'),
            )
          ],
        );
      }),
    );
  }
}
