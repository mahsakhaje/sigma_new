import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';

import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/track_orders/track_controller.dart';

class TrackingSalesOrderPage extends StatelessWidget {

  const TrackingSalesOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller with the order ID
    final args = Get.arguments;
    final String id = args['id'];
    final controller = Get.put(TrackingSalesOrderController(orderId: id));

    return DarkBackgroundWidget(
      title:'پیگیری سفارش فروش' ,
      child:Obx(() {
          if (controller.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              _buildCircleStep(controller, controller.orderStep >= 1, 'ثبت سفارش', 1),
              _buildRowStep(context, controller, controller.orderStep >= 2, 'پذیرش', 2),
              _buildRowStep(context, controller, controller.orderStep >= 3, 'کارشناسی', 3),
              _buildRowStep(context, controller, controller.orderStep >= 4, 'قیمت گذاری', 4),
              _buildRowStep(context, controller, controller.orderStep >= 5, 'ثبت آگهی', 5),
              _buildRowStep(context, controller, controller.orderStep >= 6, 'ثبت قرارداد', 6),
              _buildRowStep(context, controller, controller.orderStep >= 7, 'تایید قرارداد', 7),
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: controller.orderStep >= 7 ? AppColors.blue : Colors.white,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ],
          );
        }),

    );
  }

  Widget _buildCircleStep(TrackingSalesOrderController controller, bool isActive, String title, int step) {
    return InkWell(
      onTap: () => isActive ? controller.showStepInfo(step) : null,
      child: Container(
        height: 86,
        width: 86,
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomText(
              title,
              color:isActive ?Colors.white: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowStep(BuildContext context, TrackingSalesOrderController controller, bool isActive, String title, int step) {
    return SizedBox(
      height: 70,
      child: Directionality(
        textDirection: step % 2 == 0 ? TextDirection.rtl : TextDirection.ltr,
        child: Row(
          children: [
            SizedBox(
              width: step % 2 == 0
                  ? (MediaQuery.of(context).size.width > 700 ? 700 : MediaQuery.of(context).size.width) / 2
                  : ((MediaQuery.of(context).size.width > 700 ? 700 : MediaQuery.of(context).size.width) / 2) - 1,
              child: SizedBox(),
            ),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 35, width: 1, color: Colors.white),
                        Container(width: 56, height: 1, color: Colors.white),
                        Container(height: 34, width: 1, color: Colors.white),
                      ],
                    ),
                  ),
                  _buildCircleStep(controller, isActive, title, step),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}