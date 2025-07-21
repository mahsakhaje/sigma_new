import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/map.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/branches/branches_controller.dart';
import 'package:sigma/pages/reserve_showroom/reserve_showroom_controller.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class ReserveShowRoom extends StatelessWidget {

   ReserveShowRoom({Key? key}) : super(key: key);


   @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String id = args['id'];
    final controller = Get.put(ReserveShowRoomController(id: id));
    return DarkBackgroundWidget(
      title: 'رزرو شوروم',
          child:Obx(() => controller.detailResponse == null
                ? Center(child: loading())
                : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: [



                          SizedBox(height: 32),
                          _buildTimeSelectionSection(controller),
                          SizedBox(height: 22),
                          _buildHourSelectionSection(controller),
                          SizedBox(height: 12),
                          _buildKarshenasSelectionSection(controller),
                          SizedBox(height: 10),
                          _buildMapSection(),  SizedBox(height: 4),
                          _buildAddressContainer(controller),
                        ],
                      ),
                      _buildConfirmButton(controller),
                      SizedBox(height: 10),
                    ],
                  ),
                )),



    );
  }

  Widget _buildAddressContainer(ReserveShowRoomController controller) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(6),
          ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Wrap(children: [
          CustomText(
              (controller.detailResponse?.salesOrder?.showRoomAddress ?? "")
                  .usePersianNumbers(),
              maxLine: 3,
              isRtl: true,
              textAlign: TextAlign.justify,
              size: 15),
        ]),
      ),
    );
  }

  Widget _buildMapSection() {

    return Container( // Add Obx here
      height: 160,
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: MapScreen(),
    );
  }

  Widget _buildTimeSelectionSection(ReserveShowRoomController controller) {
    return Obx(() => CustomDropdown(
      hint: 'تاریخ مراجعه',
      value: controller.selectedTime,
      items: controller.times,
      isTurn: controller.turn == 1,
      onChanged: controller.onTimeSelected,
    ));
  }

  Widget _buildHourSelectionSection(ReserveShowRoomController controller) {
    return Obx(() => CustomDropdown(
      hint: 'انتخاب زمان',
      value: controller.selectedHour,
      items: controller.hours,
      isRtl: true,
      isTurn: controller.turn == 2,
      onChanged: controller.onHourSelected,
    ));
  }

  Widget _buildKarshenasSelectionSection(ReserveShowRoomController controller) {
    return Obx(() => CustomDropdown(
      hint: 'کارشناس راهنما',
      value: controller.selectedKarshenas,
      items: controller.karshenas,
      isTurn: controller.turn == 3,
      onChanged: controller.onKarshenasSelected,
    ));
  }

  Widget _buildConfirmButton(ReserveShowRoomController controller) {
    return Obx(() => controller.isLoading
        ? loading()
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConfirmButton(
                controller.reserveShowRoom,
                'تایید',
              ),
        ));
  }
}