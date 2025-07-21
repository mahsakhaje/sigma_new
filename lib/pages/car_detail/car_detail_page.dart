import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/badge.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/network_error_widget.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/pages/car_detail/car_detail_controller.dart'
    show CarDetailController;

import '../../helper/helper.dart';
import '../../models/car_detail_response.dart' show SalesOrder;

class CarDetailPage extends StatelessWidget {
  CarDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String id = args['id'];
    final controller = Get.put(CarDetailController(carId: id));

    return DarkBackgroundWidget(
      title: 'جزئیات خودرو',
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 0),
        child: _buildBody(controller),
      ),
    );
  }

  Widget _buildBody(CarDetailController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: SizedBox(
            height: 50,
            child: loading(),
          ),
        );
      }

      if (controller.hasError) {
        return NetworkErrorWidget(
          onRetry: controller.fetchCarDetails,
        );
      }

      if (controller.hasData) {
        return _CarDetailContent(controller: controller);
      }

      return const SizedBox.shrink();
    });
  }
}

// Content Widget
class _CarDetailContent extends StatelessWidget {
  final CarDetailController controller;

  const _CarDetailContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    final order = controller.saleOrder.value!;

    return ListView(
      physics: const ScrollPhysics(),
      padding: EdgeInsets.all(10),
      children: [
        _buildTopMenu(context, order),
        const SizedBox(height: 10),
        _buildImageSlider(context),
        _buildCarDetails(order),
        _buildReservationButton(),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _buildTopMenu(BuildContext context, SalesOrder order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            'تاریخ انتشار${order.firstAdvertiseDate}'.usePersianNumbers(),
            color: AppColors.grey,
            size: 10),
        InkWell(
          onTap: () => _showBottomSheet(context),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            padding: const EdgeInsets.all(2),
            child: const Icon(
              Icons.more_horiz_outlined,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    CustomBottomSheet.show(
      context: Get.context!,
      initialChildSize: 0.4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBottomSheetItem(
              'assets/compare.svg',
              'مقایسه آگهی',
              controller.navigateToComparison,
            ),
            Divider(
              color: Colors.grey,
            ),
            Obx(() => _buildBottomSheetItem(
                  'assets/expert.svg',
                  'برگه کارشناسی',
                  controller.downloadExpertPdf,
                  isLoading: controller.isExpertLoading.value,
                )),
            Divider(
              color: Colors.grey,
            ),
            Obx(() => _buildBottomSheetItem(
                  'assets/download.svg',
                  'دانلود کاتالوگ',
                  controller.downloadCatalog,
                  isLoading: controller.isDownloading.value,
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetItem(
    String iconPath,
    String title,
    VoidCallback onTap, {
    bool isLoading = false,
  }) {
    if (isLoading) {
      return SizedBox(
        height: 55,
        child: Center(child: loading()),
      );
    }

    return InkWell(
      onTap: onTap,
      child: ListTile(
        trailing: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(title,
                  color: Colors.black, fontWeight: FontWeight.bold, size: 14),
              SizedBox(
                width: 8,
              ),
              SvgPicture.asset(
                iconPath,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 220,
        child: Obx(() {
          final images = controller.images;
          if (images.isEmpty) {
            return Container(
              color: AppColors.grey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 46, horizontal: 12),
                child: SvgPicture.asset('assets/no_pic.svg'),
              ),
            );
          }

          return Stack(
            children: [
              PageView.builder(
                itemCount: images.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) => Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              // if (controller.saleOrder.value?.justSwap == '1')
              //   _buildBadge('فقط\nتعویض', isOrange: true),
              Positioned(
                  top: 10,
                  left: 10,
                  child: _buildOwnershipInfo()),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildIndicators(
                          images.length, controller.activePage.value),
                    )),
              ),
            ],
          );
        }),
      ),
    );
  }



  List<Widget> _buildIndicators(int length, int current) {
    if (length < 2) return [];
    return List.generate(
        length,
        (index) => Container(
              margin: const EdgeInsets.all(3),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: current == index ? Colors.white : AppColors.grey,
                shape: BoxShape.circle,
              ),
            ));
  }

  Widget _buildCarDetails(SalesOrder order) {
    return Column(
      children: [
        const SizedBox(height: 8),
        _buildCarTitle(order),
       // _buildOwnershipInfo(),
        const SizedBox(height: 8),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white)),
            child: _buildDetailRows(order)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCarTitle(SalesOrder order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            (order.lastAdvertiseDate?.usePersianNumbers() ?? "") +
                'تاریخ بروزرسانی',
            color: AppColors.lightGrey,
            size: 10),
        Row(
          children: [
            CustomText(
              '     ' + (order.persianYear ?? "0").usePersianNumbers() + '   ',
              size: 14,
            ),
            CustomText(
              ' ${order.brandDescription ?? ""} ${order.carModelDescription ?? ""}'
                  .usePersianNumbers(),
              size: 18,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOwnershipInfo() {
    return Obx(() => badge(controller.saleOrder.value?.justSwap == '1'
        ? 'فقط تعویض'
        : controller.saleOrder.value?.owner == '1'
            ? 'خودرو مانا'
            : 'خودرو امانی'));
  }

  Widget _buildDetailRows(SalesOrder order) {
    final details = [
      ('کارکرد', order.mileage ?? "0"),
      ('رنگ خودرو', order.colorDescription ?? "0"),
      (
        'قیمت',
        NumberUtils.separateThousand(
            int.tryParse(order.advertiseAmount ?? '0'.usePersianNumbers()) ?? 0)
      ),
      // ('توضیحات فروشنده', order.advertiseComment ?? "0"),
      ('نام شوروم', order.showRoomName ?? ""),
      ('شماره تماس شوروم', order.showRoomTelNumber ?? ""),
      ('آدرس شوروم', order.showRoomAddress ?? ""),
    ];

    return Column(
      children: details
          .map((detail) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildDetailRow(detail.$1, detail.$2),
              ))
          .toList(),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomText(
                value.usePersianNumbers(),
                size: 12,
                isRtl: true,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 4),
          CustomText(':', size: 14),
          const SizedBox(width: 4),
          CustomText(
            title.usePersianNumbers(),
            size: 13,
            isRtl: true,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _buildReservationButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ConfirmButton(
          controller.navigateToReservation,
          'رزرو شوروم',
        ),
      ),
    );
  }
}
