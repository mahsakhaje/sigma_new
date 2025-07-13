import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/global_custom_widgets/outlined_button.dart';
import 'package:sigma/helper/colors.dart' as colors;
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';
import 'package:sigma/pages/advertise/advertise_controller.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AdvertisePage extends StatelessWidget {
  final AdvertiseController controller = Get.put(AdvertiseController());

  @override
  Widget build(BuildContext context) {
    ever(controller.showFilterModal, (bool show) {
      if (show && controller.pageState.value == AdvertisePageState.list) {
        // Use Future.delayed to avoid calling during build
        Future.delayed(Duration.zero, () {
          CustomBottomSheet.show(
            context: Get.context!,
            initialChildSize: 0.8,
            child: Obx(() => _buildFilterWidget()),
          ).then((_) {
            controller.showFilterModal.value = false;
          });
        });
      } else {
        // Close the modal if it's open
        if (Navigator.canPop(Get.context!)) {
          Navigator.pop(Get.context!);
        }
      }
    });
    return DarkBackgroundWidget(
      title: controller.isCompareMode.value
          ? 'انتخاب برای مقایسه'
          : Strings.advertises,
      child: Obx(() => buildBody()),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: controller.togglePageState,
                  child: SvgPicture.asset('assets/filter.svg'),
                )
              ]),
              Expanded(
                child: controller.filterLoading.value
                    ? Center(child: loading())
                    : _buildListWidget(),
              ),
            ],
          ),
        ),
        // if (controller.isLoading.value && controller.orders.isEmpty)
        //   Center(child: loading()),
      ],
    );
  }

  Widget _buildListWidget() {
    if (controller.orders.isEmpty && !controller.isLoading.value) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NoContent(),
          SizedBox(height: 24),
          CustomText(
            'در صورتی که خودرو موردنظر خود را پیدا نکردید میتوانید سفارش خرید خود راثبت نمایید',
            isRtl: true,
            size: 14,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          SizedBox(
            width: 160,
            height: 50,
            child: ConfirmButton(
              () => Get.toNamed(RouteName.buy),
              'ثبت سفارش خرید',
            ),
          ),
        ],
      );
    }

    return GridView.builder(
      controller: controller.scrollController,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
        childAspectRatio: 0.66, // Width to height ratio of grid items
      ),
      itemCount: controller.hasMore.value
          ? controller.orders.length + 1
          : controller.orders.length,
      // controller: controller.scrollController,
      itemBuilder: (ctx, index) {
        if (index == 0 && controller.orders.isEmpty) {
          return Center(child: loading());
        }
        if (index == controller.orders.length &&
            controller.hasMore.value &&
            index > 0) {
          return Center(child: loading());
        }
        return advertiseItem(controller.orders[index], () async {
          await controller.changeLike(controller.orders[index].id ?? '');
        }, controller);
      },
    );
  }

  Widget _buildFilterWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.modalGrey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildExpandable(
            'شهر',
            ListView(
              physics: const ScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              children: controller.cities
                  .map((timeValue) =>
                      multiSelectWidget(timeValue, MultiSelectListType.City))
                  .toList(),
            ),
            controller.cities.length * 58,
            0,
            MultiSelectListType.City,
          ),
          buildExpandable(
            'برند',
            ListView(
              physics: const ScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              children: controller.brands
                  .map((timeValue) =>
                      multiSelectWidget(timeValue, MultiSelectListType.Brand))
                  .toList(),
            ),
            controller.brands.length * 58,
            1,
            MultiSelectListType.Brand,
          ),
          buildExpandable(
            'مدل خودرو',
            ListView(
              physics: const ScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              children: controller.carModels
                  .map((timeValue) =>
                      multiSelectWidget(timeValue, MultiSelectListType.Model))
                  .toList(),
            ),
            controller.carModels.length * 54,
            2,
            MultiSelectListType.Model,
          ),
          buildExpandable(
            'تیپ خودرو',
            ListView(
              physics: const ScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              children: controller.carTypes
                  .map((timeValue) =>
                      multiSelectWidget(timeValue, MultiSelectListType.Type))
                  .toList(),
            ),
            controller.carTypes.length * 54,
            3,
            MultiSelectListType.Type,
          ),
          buildExpandable(
            'رنگ بدنه',
            ListView(
              physics: const ScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              children: controller.colorsCars
                  .map((timeValue) =>
                      multiSelectWidget(timeValue, MultiSelectListType.Color))
                  .toList(),
            ),
            controller.colorsCars.length * 36,
            4,
            MultiSelectListType.Color,
          ),
          buildExpandable(
            'قیمت',
            SizedBox(
              width: Get.width,
              height: 150,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // color: colors.dropdowncolor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'از' +
                                '  ' +
                                NumberUtils.toTomans(
                                    controller.priceValues.value.start *
                                        10000000),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // color: colors.dropdowncolor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'تا' +
                                '  ' +
                                NumberUtils.toTomans(
                                    controller.priceValues.value.end *
                                        10000000),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                  SizedBox(height: 16),
                  SfRangeSlider(
                    min: 200.0,
                    max: 9000,
                    values: controller.priceValues.value,
                    interval: 1000,
                    showTicks: false,
                    stepSize: 100,
                    showLabels: false,
                    enableTooltip: false,
                    minorTicksPerInterval: 1000,
                    onChanged: controller.updatePriceValues,
                  ),
                ],
              ),
            ),
            140,
            5,
            MultiSelectListType.None,
          ),
          if (controller.fromYears.isNotEmpty)
            buildExpandable(
              'سال ساخت',
              SizedBox(
                width: Get.width,
                height: 240,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              //  color: colors.dropdowncolor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'از' +
                                  '  ' +
                                  controller.yearValues.value.start
                                      .toInt()
                                      .toString()
                                      .usePersianNumbers(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              // color: colors.dropdowncolor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'تا' +
                                  '  ' +
                                  controller.yearValues.value.end
                                      .toInt()
                                      .toString()
                                      .usePersianNumbers(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                    SizedBox(height: 24),
                    SfRangeSlider(
                      min: controller.fromYears[0].id,
                      max: controller.fromYears.last.id,
                      values: controller.yearValues.value,
                      interval: 1,
                      showTicks: false,
                      stepSize: 1,
                      showLabels: false,
                      enableTooltip: false,
                      onChanged: controller.updateYearValues,
                    ),
                  ],
                ),
              ),
              240,
              6,
              MultiSelectListType.None,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: customOutlinedButton(
                        controller.resetFilters, 'حذف همه',
                        borderColorolor: Colors.black,
                        txtColor: Colors.black)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ConfirmButton(
                        controller.applyFilters, 'اعمال فیلتر')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget multiSelectWidget(TimeValue value, MultiSelectListType listType) {
    return Obx(() => Row(
          children: [
            Checkbox(
              shape: CircleBorder(),
              value: controller.getValue(listType, value),
              onChanged: (checked) {
                if (checked == null) return;

                switch (listType) {
                  case MultiSelectListType.Brand:
                    controller.toggleBrand(value, checked);
                    break;
                  case MultiSelectListType.Model:
                    controller.toggleModel(value, checked);
                    break;
                  case MultiSelectListType.Type:
                    controller.toggleType(value, checked);
                    break;
                  case MultiSelectListType.Color:
                    controller.toggleColor(value, checked);
                    break;
                  case MultiSelectListType.City:
                    controller.toggleCity(value, checked);
                    break;
                  default:
                    break;
                }
              },
            ),
            CustomText(value.value,color: Colors.black),
          ],
        ));
  }

  Directionality buildExpandable(
    String title,
    Widget body,
    double len,
    int index,
    MultiSelectListType type,
  ) {
    String subtitle = controller.getSubtitleOfSections(type);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.darkGrey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ExpansionTile(
          collapsedIconColor: Colors.black,
          iconColor: Colors.black,
          textColor: Colors.black,
          onExpansionChanged: (isExpanded) {
            controller.toggleExpansionTile(index);
          },
          initiallyExpanded: controller.isExpandedList[index],
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          title: Row(
            children: [
              CustomText(
                title,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 8),
              CustomText(subtitle == "[]" ? '' : subtitle,
                  // color: colors.disableColor,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey),
            ],
          ),
          children: [
            Container(
              height: len,
              color: AppColors.lightGrey,
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

class advertiseItem extends StatelessWidget {
  final SalesOrders order;
  final VoidCallback onTap;
  final AdvertiseController controller; // اضافه کردن controller

  advertiseItem(this.order, this.onTap, this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.handleCarItemTap(order.id ?? ''),
      // استفاده از متد جدید
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 9, horizontal: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            // اضافه کردن نشانگر مقایسه
            if (controller.isCompareMode.value)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: CustomText(
                    'کلیک برای مقایسه',
                    size: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            Row(
              children: [
                Expanded(
                  child: order.salesOrderDocuments == null ||
                          order.salesOrderDocuments!.isEmpty ||
                          (order.salesOrderDocuments?.length ?? 0) < 1
                      ? ClipRRect(
                          borderRadius: controller.isCompareMode.value
                              ? BorderRadius.zero
                              : BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                          child: Container(
                            height: controller.isCompareMode.value ? 80 : 100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 28, horizontal: 18),
                              child: SvgPicture.asset('assets/no_pic.svg'),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: controller.isCompareMode.value
                              ? BorderRadius.zero
                              : BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                          child: Image.network(
                            '${URLs.imageLinks}${order.salesOrderDocuments![0].docId ?? ""}',
                            fit: BoxFit.cover,
                            height: controller.isCompareMode.value ? 80 : 100,
                          ),
                        ),
                ),
              ],
            ),

            // ... بقیه کد موجود بدون تغییر ...
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        order.brandDescription ?? '',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        size: 16,
                      ),

                      SizedBox(width: 4),
                      CustomText(
                        order.carModelDescription ?? '',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        size: 16,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        (order.persianYear ?? '').usePersianNumbers() + ' مدل ',
                        color: Colors.black87,
                        size: 11,
                      ),
                      SizedBox(width: 4),
                      CustomText(
                        order.colorDescription ?? '',
                        color: Colors.black87,
                        size: 11,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText('تومان', color: Colors.black87),
                      SizedBox(width: 2),
                      Flexible(
                        child: CustomText(
                          NumberUtils.separateThousand(
                                  int.tryParse(order.advertiseAmount ?? '0') ??
                                      0)
                              .usePersianNumbers(),
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 4),
                      CustomText('قیمت', color: Colors.black87),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      InkWell(
                        onTap: onTap,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (order.favCount != null &&
                                  (int.tryParse(order.favCount!) ?? 0) == 1)
                              ? SvgPicture.asset('assets/red_heart.svg')
                              : SvgPicture.asset('assets/heart.svg'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
