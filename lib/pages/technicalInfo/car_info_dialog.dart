import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/technicalInfo/technicalInfro_controller.dart';

class CarSpecsDialog extends StatelessWidget {
  final String carTypeId;
  final String carName;
  final String imagePath;

  const CarSpecsDialog({
    Key? key,
    required this.carTypeId,
    required this.carName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TechnicalInfoController controller =
        Get.put(TechnicalInfoController());

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                imagePath ?? "",
                fit: BoxFit.cover,
                width: Get.width,
                height: 180,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.showMoreBottomSheet(
                      carTypeId, imagePath, carName),
                  child: SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(
                          'assets/more.svg',
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CustomText('بیشتر', color: Colors.black, size: 14)
                      ],
                    ),
                  ),
                ),
                CustomText(
                  carName,
                  color: Colors.black,
                  size: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(width: 80, child: Container())
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.changeTab(0);
                          // controller.getCarSpecTypes(carTypeId);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: controller.selectedTab.value == 0
                                ? Colors.black87
                                : Colors.grey[200],
                          ),
                          child: CustomText('مشخصات فنی',
                              textAlign: TextAlign.center,
                              color: controller.selectedTab.value == 0
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.changeTab(1);
                          //  controller.getCarEquipments(carTypeId);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: controller.selectedTab.value == 1
                                ? Colors.black87
                                : Colors.grey[200],
                          ),
                          child: CustomText('تجهیزات و امکانات',
                              color: controller.selectedTab.value == 1
                                  ? Colors.white
                                  : Colors.black,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: loading(),
                  );
                }

                if (controller.selectedTab.value == 0) {
                  // Technical Specifications Tab
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.carSpecs.length,
                    itemBuilder: (context, index) {
                      final spec = controller.carSpecs[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SizedBox(
                          height: 34,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(

                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,

                                      children: [
                                        Flexible(
                                          child: CustomText(
                                              (spec?.description?.trim() ?? "")
                                                  .usePersianNumbers(),
                                              size: 12,
                                              maxLine: 2,
                                              color: Colors.black,
                                              textAlign: TextAlign.justify,
                                              isRtl: true),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(

                                children: [
                                  Row(
                                    children: [
                                      CustomText(' : ', color: Colors.black),

                                      CustomText(
                                          (spec?.specTypeDescription?.trim() ?? "")
                                              .usePersianNumbers(),
                                          size: 12,
                                          color: Colors.black,
                                          isRtl: true),
                                      const SizedBox(width: 12),
                                      SvgPicture.asset('assets/okt.svg'),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // Equipment & Features Tab
                  print(controller.carEquipments);
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.carEquipments.length,
                    itemBuilder: (context, index) {
                      String equipment = controller.carEquipments[index]??'';
                      if(equipment.isEmpty){
                        return SizedBox();
                      }
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                  equipment?.usePersianNumbers() ?? '',
                                  size: 12,
                                  color: Colors.black,
                                  isRtl: true),
                            ),
                            const SizedBox(width: 12),
                            SvgPicture.asset('assets/okt.svg'),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
