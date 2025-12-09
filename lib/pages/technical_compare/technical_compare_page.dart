import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/technical_compare/technical_compare_controller.dart';

class TechnicalComparePage extends StatelessWidget {
  const TechnicalComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String firstId = args['firstId'];
    final String secondId = args['secondId'];
    final String firstCarName = args['firstCarName'];
    final String firstCarImagePath = args['firstCarImagePath'];
    final String secondcarName = args['secondcarName'];
    final String secondcarImagePath = args['secondcarImagePath'];
    print(args);
    var controller = Get.put(
        TechnicalCompareController(firstId: firstId, secondId: secondId));

    return DarkBackgroundWidget(
        child: Obx(() => _buildBody(controller, firstCarName, firstCarImagePath,
            secondcarName, secondcarImagePath)),
        title: Strings.carCompare);
  }

  Widget _buildBody(
      TechnicalCompareController controller,
      String firstCarName,
      String firstCarImagePath,
      String secondCarName,
      String secondCarImagePath) {
    if (controller.isGettingCarInfo.value) {
      return Center(
        child: loading(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          firstCarImagePath ?? "",
                          fit: BoxFit.contain,
                          width: Get.width,
                        ),
                      ),
                      Container(height: 40,
                        color: AppColors.darkGrey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(firstCarName,fontWeight: FontWeight.bold,size: 16),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText('تجهیزات و امکانات',
                          color: Colors.black,
                          size: 16,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          separatorBuilder: (ctx, index) {
                            return Divider();
                          },
                          itemCount: controller.firstCarEquipments.length < 10
                              ? controller.firstCarEquipments.length
                              : 10,
                          itemBuilder: (ctx, index) {
                            return CustomText(
                                textAlign: TextAlign.justify,

                                controller.firstCarEquipments[index] ?? '',
                                color: Colors.black,
                                isRtl: true);
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText('مشخصات فنی',
                          color: Colors.black,
                          size: 16,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          separatorBuilder: (ctx, index) {
                            return Divider();
                          },
                          itemCount: controller.firstCarSpecs.length < 10
                              ? controller.firstCarSpecs.length
                              : 10,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height:20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          ':',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          isRtl: true),
                                      CustomText(
                                          textAlign: TextAlign.justify,

                                          (controller.firstCarSpecs[index]?.specTypeDescription ??
                                              ''),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          isRtl: true),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8,),
                                CustomText(
                                    controller.firstCarSpecs[index]?.description ??
                                        '',
                                    textAlign: TextAlign.justify,
                                    color: Colors.black,
                                    isRtl: true),
                              ],
                            );
                          })
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              secondCarImagePath ?? "",
                              fit: BoxFit.contain,
                              width: Get.width,
                            ),
                          ),
                          Container(height: 40,
                            color: AppColors.cardGrey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(secondCarName,fontWeight: FontWeight.bold,size: 16),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText('تجهیزات و امکانات',
                              color: Colors.black,
                              size: 16,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              separatorBuilder: (ctx, index) {
                                return Divider();
                              },
                              itemCount: controller.secondCarEquipments.length < 10
                                  ? controller.secondCarEquipments.length
                                  : 10,
                              itemBuilder: (ctx, index) {
                                return CustomText(
                                    controller.secondCarEquipments[index] ?? '',
                                    color: Colors.black,                                    textAlign: TextAlign.justify,

                                    isRtl: true);
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText('مشخصات فنی',
                              color: Colors.black,
                              size: 16,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              separatorBuilder: (ctx, index) {
                                return Divider();
                              },
                              itemCount: controller.secondCarSpecs.length < 10
                                  ? controller.secondCarSpecs.length
                                  : 10,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height:20,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              ':',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              isRtl: true),
                                          CustomText(
                                              (controller.secondCarSpecs[index]?.specTypeDescription ??
                                                  ''),
                                              textAlign: TextAlign.justify,

                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              isRtl: true),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    CustomText(
                                        controller.secondCarSpecs[index]?.description ??
                                            '',
                                        textAlign: TextAlign.justify,

                                        color: Colors.black,
                                        isRtl: true),
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                  )),
            ],
          ))
        ],
      ),
    );
  }
}
