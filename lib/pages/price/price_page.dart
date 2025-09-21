import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_check_box.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/global_custom_widgets/outlined_button.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/models/all_cars_json_model.dart';
import 'package:sigma/models/mana_prices_response.dart';
import 'package:sigma/models/PriceItems Response.dart';
import 'package:sigma/pages/buy_menu/buy/buy_page.dart';
import 'package:sigma/pages/price/price_controller.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../global_custom_widgets/loading.dart';
import '../buy_menu/buy_menu_page.dart';

class PricePage extends StatelessWidget {
  final PricePageController controller = Get.put(PricePageController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: Strings.carPrice,
      child: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: Obx(() => controller.selectedTabIndex.value == 0
                ? _buildDailyPriceTab()
                : _buildPriceEstimationTab()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: customOutlinedButton(
                () => Get.toNamed(RouteName.sell), 'ثبت سفارش فروش'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Obx(() => Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF333333),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeTab(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.selectedTabIndex.value == 1
                          ? AppColors.grey
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: CustomText(
                        Strings.dailyPrice,
                        color: controller.selectedTabIndex.value == 1
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeTab(1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.selectedTabIndex.value == 0
                          ? AppColors.grey
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: CustomText(
                        Strings.estimatePrice,
                        color: controller.selectedTabIndex.value == 0
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // Daily Price Tab
  Widget _buildDailyPriceTab() {
    return Obx(() {
      if (controller.isManaPricesLoading.value) {
        return Center(
          child: loading(),
        );
      }

      if (controller.manaPrices.isEmpty) {
        return NoContent();
      }

      return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: controller.manaPrices.length,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          itemBuilder: (ctx, index) {
            return _buildPriceItem(controller.manaPrices[index]);
          });
    });
  }

  Widget _buildPriceItem(ManaPrices price) {
    return Container(
      height: 230,
      width: Get.width,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            price.imagePath == null
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      color: AppColors.lightGrey,
                      height: 180,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 36, horizontal: 18),
                        child: SvgPicture.asset('assets/no_pic.svg'),
                      ),
                    ))
                : ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Stack(
                      children: [
                        Image.network(
                          price.imagePath ?? "",
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: 180,
                        ),
                        // badge(
                        //     (((price.updatePriceDate?.length ?? 0) > 4
                        //         ? price.updatePriceDate?.substring(0, 4)
                        //         : '1403') ?? ''
                        //     ).usePersianNumbers(),
                        //     height: 70
                        // )
                      ],
                    )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(' تومان',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          isRtl: true,
                          size: 12),
                      CustomText(
                          (price?.leastPrice ?? "0").usePersianNumbers() +
                              ' تا ' +
                              (price?.mostPrice ?? "0").usePersianNumbers(),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          isRtl: true,
                          size: 12),
                    ],
                  ),
                  CustomText(price.carModel ?? '',
                      size: 12,
                      isRtl: true,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Price Estimation Tab
  Widget _buildPriceEstimationTab() {
    return Obx(() {
      if (controller.isAllCarsLoading.value) {
        return Center(
          child: loading(),
        );
      }

      return controller.state.value == PageState.Form
          ? _buildPriceEstimationForm()
          : _buildCarStateForm();
    });
  }

  Widget _buildPriceEstimationForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          CustomText('اطلاعات پایه خودرو',
              size: 16,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.right),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Obx(() => CustomDropdown(
                      hint: 'مدل خودرو',
                      isEng: true,
                      items: controller.carModels.value,
                      isTurn: controller.turn.value == 2,
                      value: controller.selectedCarModel.value,
                      onChanged: (String? str) =>
                          controller.updateCarModel(str),
                    )),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Obx(() => CustomDropdown(
                      hint: 'برند خودرو',
                      value: controller.selectedBrand.value,
                      items: controller.brands.value,
                      isTurn: controller.turn.value == 1,
                      onChanged: (String? str) => controller.updateBrand(str),
                    )),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Obx(() => CustomDropdown(
                      hint: 'رنگ خودرو',
                isRtl: true,
                      isTurn: controller.turn.value == 4,
                      value: controller.selectedColors.value,
                      items: controller.colorsCars.value,
                      onChanged: (String? str) => controller.updateColors(str),
                    )),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Obx(() => CustomDropdown(
                      hint: 'تیپ خودرو',
                      value: controller.selectedCarType.value,
                      items: controller.carTypes.value,
                      isTurn: controller.turn.value == 3,
                      onChanged: (String? str) => controller.updateCarType(str),
                    )),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Obx(() => CustomDropdown(
                      hint: 'گارانتی',
                      value: controller.selectedGaurantee.value,
                      items: controller.guarantee.value,
                      isTurn: controller.turn.value == 6,
                      onChanged: (String? str) =>
                          controller.updateGuarantee(str),
                    )),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Obx(() => CustomDropdown(
                      hint: 'سال ساخت ',
                      isTurn: controller.turn.value == 5,
                      value: controller.selectedFromYear.value,
                      items: controller.carTypeManufactureYears.value,
                      onChanged: (String? str) =>
                          controller.updateFromYear(str),
                    )),
              ),
            ],
          ),
          SizedBox(height: 8),
          CustomText('کارکرد خودرو',
              size: 16,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.right),
          SizedBox(height: 12),
          CustomTextFormField(
            controller.millageController,
            hintText: 'کارکرد',
            maxLen: 7,
            isOnlyNumber: true,
            onEditingComplete: () {
              controller.turn.value = 8;
            },
            onChanged: (str) => controller.updateMileage(str),
          ),
          Obx(
            () => SfRangeSliderTheme(
              data: SfRangeSliderThemeData(
                tooltipBackgroundColor: AppColors.orange,
              ),
              child: SfRangeSlider(
                min: 0,
                max: 100000,
                values: controller.kilometerValues.value,
                interval: 1000,
                showTicks: false,
                stepSize: 100,
                showLabels: false,
                activeColor: Colors.white,
                enableTooltip: true,
                minorTicksPerInterval: 1000,
                onChanged: (SfRangeValues values) =>
                    controller.updateKilometerValues(values),
              ),
            ),
          ),
          CustomText('وضعیت بدنه',
              size: 16,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.right),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              Row(
                children: [
                  CustomText('ناسالم'),
                  CustomCheckBox(
                    value: controller.selectedIdsMap.value.isNotEmpty,
                    onChanged: (bool? value) {
                      if (value == true) {
                        _showCarDamageBottomSheet();
                      } else {
                        controller.resetCarStatus();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Row(
                children: [
                  CustomText('سالم'),
                  CustomCheckBox(
                    value: controller.selectedIdsMap.value.isEmpty,
                    onChanged: (bool? value) {
                      if (value == true) {
                        controller.resetCarStatus();
                      }
                    },
                  ),
                ],
              ),

              // ناسالم checkbox
            ],
          ),
          //_buildDamageSummary(),
          SizedBox(height: 12),
          ConfirmButton(
            () async {
              bool success = await controller.calculatePrice();
              if (success) {
                _showPriceResultDialog();
              }
            },
            "محاسبه قیمت",
          ),
        ],
      ),
    );
  }

  // void _showCarDamageBottomSheet() {
  //   showModalBottomSheet(
  //     context: Get.context!,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => DraggableScrollableSheet(
  //       initialChildSize: 0.7,
  //       minChildSize: 0.5,
  //       maxChildSize: 0.9,
  //       builder: (context, scrollController) => Container(
  //         decoration: BoxDecoration(
  //           color: AppColors.modalGrey,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //         ),
  //         child: Column(
  //           children: [
  //             // Header
  //
  //             // Content
  //             Expanded(
  //               child: Obx(() => ListView(
  //                     controller: scrollController,
  //                     padding: EdgeInsets.all(16),
  //                     children: _buildDamageItemsList(),
  //                   )),
  //             ),
  //
  //             // Bottom buttons
  //             Container(
  //               padding: EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.2),
  //                     spreadRadius: 1,
  //                     blurRadius: 5,
  //                     offset: Offset(0, -3),
  //                   ),
  //                 ],
  //               ),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: customOutlinedButton(
  //                       () => controller.clearAllSelections(),
  //                       'حذف همه',
  //                     ),
  //                   ),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: ConfirmButton(
  //                       () => Navigator.pop(context),
  //                       'تایید',
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

// Build damage items list for bottom sheet
//   List<Widget> _buildDamageItemsList() {
//     List<Widget> buildExpandables = [];
//
//     if (controller.priceItems.value != null) {
//       controller.priceItems.value!.forEach((element) {
//         List<Widget> buildValues = [];
//
//         element.values?.forEach((valueElement) {
//           buildValues.add(
//             Obx(() => RadioListTile<String>(
//                   value: valueElement.id ?? "",
//                   groupValue: controller.selectedIdsMap.value[element.id] ==
//                           valueElement.id
//                       ? valueElement.id
//                       : null,
//                   onChanged: (val) {
//                     controller.updateItemSelection(
//                       element.id ?? "",
//                       val ?? "",
//                       element.description ?? "",
//                       valueElement.description ?? "",
//                     );
//                   },
//                   title: CustomText(
//                     valueElement.description ?? "",
//                     color: Colors.black87,
//                   ),
//                   activeColor: Colors.orange,
//                 )),
//           );
//         });
//
//         buildExpandables
//             .add(_buildExpandableItem(element.description ?? "", buildValues));
//       });
//     }
//
//     return buildExpandables;
//   }

  void _showCarDamageBottomSheet() {
    CustomBottomSheet.show(
        context: Get.context!,
        initialChildSize: controller.priceItems.value == null ||
                controller.priceItems.value!.isEmpty
            ? 0.3
            : 0.7,
        child: Column(
          children: [
            // Header - اضافه شده

            // Content
            Obx(() {
              // بررسی وجود داده‌ها
              if (controller.priceItems.value == null ||
                  controller.priceItems.value!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 48,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      CustomText('اطلاعات آسیب خودرو موجود نیست.',
                          size: 16, color: Colors.grey.shade600, isRtl: true),
                      SizedBox(height: 8),
                      CustomText('لطفاً ابتدا مشخصات خودرو را کامل کنید.',
                          size: 14, color: Colors.grey.shade500, isRtl: true),
                    ],
                  ),
                );
              }

              return ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                children: _buildDamageItemsList(),
              );
            }),

            // Bottom buttons
            controller.priceItems.value == null ||
                    controller.priceItems.value!.isEmpty
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: customOutlinedButton(
                              () => controller.clearAllSelections(), 'حذف همه',
                              borderColorolor: AppColors.darkGrey,
                              txtColor: AppColors.darkGrey),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ConfirmButton(
                            () => Get.back(),
                            'تایید',
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ));
  }

// تصحیح متد _buildDamageItemsList
  List<Widget> _buildDamageItemsList() {
    List<Widget> buildExpandables = [];

    if (controller.priceItems.value != null &&
        controller.priceItems.value!.isNotEmpty) {
      controller.priceItems.value!.forEach((element) {
        List<Widget> buildValues = [];

        // بررسی وجود values
        if (element.values != null && element.values!.isNotEmpty) {
          element.values!.forEach((valueElement) {
            buildValues.add(
              Obx(() => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                      ),
                    ),
                    child: RadioListTile<String>(
                      activeColor: AppColors.blue,
                      value: valueElement.id ?? "",
                      groupValue: controller.selectedIdsMap.value[element.id] ==
                              valueElement.id
                          ? valueElement.id
                          : null,
                      onChanged: (val) {
                        controller.updateItemSelection(
                          element.id ?? "",
                          val ?? "",
                          element.description ?? "",
                          valueElement.description ?? "",
                        );
                      },
                      title: CustomText(valueElement.description ?? "",
                          color: Colors.black87,
                          textAlign: TextAlign.right,
                          size: 14,
                          fontWeight: FontWeight.w400),
                      //activeColor: Colors.orange,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  )),
            );
          });
        }

        // فقط اگر آیتم‌هایی وجود داشته باشد اضافه کن
        if (buildValues.isNotEmpty) {
          buildExpandables.add(_buildExpandableItem(
              element.description ?? "بدون عنوان", buildValues));
        }
      });
    }

    return buildExpandables;
  }

// تصحیح متد _buildExpandableItem
  Widget _buildExpandableItem(String title, List<Widget> body) {
    return Obx(() {
      String? desc = controller.carStatusDescription.value[title];

      return Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: AppColors.darkGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          collapsedIconColor: Colors.black87,
          textColor: Colors.black87,
          iconColor: AppColors.blue,
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (desc != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(desc, color: AppColors.darkGrey),
                ),
              Expanded(
                child: CustomText(
                  title,
                  size: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          children: body,
        ),
      );
    });
  }

// Build expandable item for bottom sheet
//   Widget _buildExpandableItem(String title, List<Widget> body) {
//     return Obx(() {
//       String? desc = controller.carStatusDescription.value[title];
//
//       return Container(
//         margin: EdgeInsets.symmetric(vertical: 4),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade50,
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: ExpansionTile(
//           collapsedIconColor: Colors.black,
//           iconColor: Colors.black,
//           textColor: Colors.black,
//           childrenPadding: EdgeInsets.zero,
//           tilePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//           title: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               if (desc != null)
//                 Text(
//                   ' - $desc',
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//             ],
//           ),
//           children: body,
//         ),
//       );
//     });
//   }

  Widget _buildCarStateForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customOutlinedButton(
                () => controller.switchToFormState(),
                'بازگشت',
              ),
              CustomText(
                'انتخاب نقاط آسیب دیده',
                fontWeight: FontWeight.bold,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
              child: controller.priceItems.value == null ||
                      controller.priceItems.value!.isEmpty
                  ? Center(
                      child: CustomText('اطلاعاتی وجود ندارد', size: 16),
                    )
                  : Obx(() => ListView.builder(
                        itemCount: controller.priceItems.value!.length,
                        itemBuilder: (context, index) {
                          return _buildPriceItemCard(
                              controller.priceItems.value![index]);
                        },
                      ))),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: customOutlinedButton(
                  () => controller.clearAllSelections(),
                  'پاک کردن همه',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ConfirmButton(
                  () => controller.switchToFormState(),
                  'تایید و ادامه',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceItemCard(PriceItems item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              item.description ?? '',
              fontWeight: FontWeight.bold,
              size: 16,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 12),
            Obx(() {
              final itemValues = item.values ?? [];
              final elementId = item.id ?? '';
              final isObserved = controller.selectedIdsMap.value;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemValues.length,
                itemBuilder: (context, index) {
                  final itemValue = itemValues[index];
                  final isSelected =
                      controller.selectedIdsMap.value.containsKey(elementId) &&
                          controller.selectedIdsMap.value[elementId] ==
                              itemValue.id;

                  return InkWell(
                    onTap: () => controller.updateItemSelection(
                        elementId,
                        itemValue.id ?? '',
                        item.description ?? '',
                        itemValue.description ?? ''),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.3)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isSelected
                              ? _buildCheckIcon()
                              : const SizedBox(width: 24),
                          CustomText(
                            itemValue.description ?? '',
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  void _showPriceResultDialog() {
    showModalBottomSheet(
      context: Get.context!,
      enableDrag: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.modalGrey,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            _buildPriceInfoRow('قیمت تخمینی:',
                '${controller.price.value.usePersianNumbers()} تومان'),
            const SizedBox(height: 16),
            _buildPriceInfoRow('کمترین قیمت:',
                '${controller.lowestPrice.value.usePersianNumbers()} تومان'),
            const SizedBox(height: 16),
            _buildPriceInfoRow('بیشترین قیمت:',
                '${controller.highestPrice.value.usePersianNumbers()} تومان'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ConfirmButton(
                () => Get.back(),
                'متوجه شدم',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          value,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          isRtl: true,
          size: 14,
        ),
        CustomText(
          title,
          size: 14,
          isRtl: true,
          color: Colors.black87,
        ),
      ],
    );
  }
}
