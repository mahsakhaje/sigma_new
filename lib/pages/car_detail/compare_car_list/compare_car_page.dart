import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';
import 'package:sigma/pages/car_detail/compare_car_list/compare_car_controller.dart';

class CompareAdvertisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String compareCarId = Get.arguments as String;
    CompareAdvertiseController controller =
        Get.put(CompareAdvertiseController(compareCarId));

    return DarkBackgroundWidget(
      title: 'انتخاب برای مقایسه',
      child: Obx(() => buildBody(controller)),
    );
  }

  Widget buildBody(CompareAdvertiseController controller) {
    return controller.isLoading.value && controller.orders.isEmpty
        ? Center(child: loading())
        : _buildListWidget(controller);
  }

  Widget _buildListWidget(CompareAdvertiseController controller) {
    return CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        /// GridView (SliverGrid)
        (controller.orders.isEmpty && !controller.isLoading.value)
            ? SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: NoContent(),
                      ),
                      CustomText(
                        'هیچ آگهی‌ای برای مقایسه یافت نشد.',
                        isRtl: true,
                        size: 16,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      if (index == 0 && controller.orders.isEmpty) {
                        return SizedBox();
                      }
                      if (index == controller.orders.length &&
                          controller.hasMore.value &&
                          index > 0) {
                        return loading();
                      }

                      final order = controller.orders[index];
                      return compareAdvertiseItem(order, controller);
                    },
                    childCount: controller.hasMore.value
                        ? controller.orders.length + 1
                        : controller.orders.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.66,
                  ),
                ),
              ),
      ],
    );
  }
}

class compareAdvertiseItem extends StatelessWidget {
  final SalesOrders order;
  final CompareAdvertiseController controller;

  compareAdvertiseItem(this.order, this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.handleCarItemTap(order.id ?? ''),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 9, horizontal: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            // نشانگر مقایسه
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
                          borderRadius: BorderRadius.zero,
                          child: Container(
                            height: 120,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 28, horizontal: 18),
                              child: SvgPicture.asset('assets/no_pic.svg'),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: Image.network(
                            '${URLs.imageLinks}${order.salesOrderDocuments![0].docId ?? ""}',
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                        ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
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
                          (order.persianYear ?? '').usePersianNumbers() +
                              ' مدل ',
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
                            NumberUtils.separateThousand(int.tryParse(
                                        order.advertiseAmount ?? '0') ??
                                    0)
                                .usePersianNumbers(),
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 4),
                        CustomText('قیمت', color: Colors.black87),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
