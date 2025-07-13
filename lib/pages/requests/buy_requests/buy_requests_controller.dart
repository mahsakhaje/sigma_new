import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/detail_widget.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/my_purchase_order_response.dart';

class MyBuyOrdersController extends GetxController {
  final RxList<PurchaseOrders> purchaseOrders = <PurchaseOrders>[].obs;
  final RxInt pn = 1.obs;
  final RxInt pl = 10.obs;
  final RxInt total = 0.obs;
  final RxBool hasMore = true.obs;
  final RxBool isLoading = true.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _setupScrollListener();
    _loadInitialData();
  }

  void _setupScrollListener() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (hasMore.value) {
          await getData();
        }
      }
    });
  }

  Future<void> _loadInitialData() async {
    await getData();
    isLoading.value = false;
  }

  Future<void> getData() async {
    pn.value++;
    var response = await DioClient.instance
        .getMyPurchaseOrders(pl: pl.value, pn: pn.value);

    if (response != null) {
      if (pn.value == 1) {
        purchaseOrders.value = response.purchaseOrders ?? [];
      } else {
        purchaseOrders.addAll(response.purchaseOrders ?? []);
      }
      total.value = int.tryParse(response.count ?? '0') ?? 0;
    }

    hasMore.value = total.value != purchaseOrders.length;
  }

  void reset() {
    pn.value = 1;
    total.value = 0;
    hasMore.value = true;
    purchaseOrders.clear();
    isLoading.value = true;
  }

  Future<void> refreshData() async {
    reset();
    await getData();
    isLoading.value = false;
  }

  Future<void> navigateToRating(PurchaseOrders order) async {
    // await navigateToScreen(
    //   Get.context!,
    //   rating,
    //   argument: RatingInfo(
    //     id: order.id ?? "",
    //     comment: order.rateComment,
    //     ratingStateEnum: RatingStateEnum.PurchaseRating,
    //   ),
    // );
    await refreshData();
  }

  Future<void> onProposalsPressed(PurchaseOrders order) async {
    CustomBottomSheet.show(
        initialChildSize: 0.3,
        context: Get.context!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  Get.back(result: false);
                  showMyBuyDetailDialog(Get.context!, order);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('جزئیات',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset('assets/detail.svg')
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void showMyBuyDetailDialog(BuildContext context, PurchaseOrders order) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  detailItem(
                      order.trimColorDescription == null ||
                              (order.trimColorDescription?.isEmpty ?? false)
                          ? "-"
                          : order.trimColorDescription!,
                      'رنگ داخل خودرو'),
                  Divider(),
                  detailItem(
                      order.registerDate == null ||
                              (order.registerDate?.isEmpty ?? false)
                          ? "-"
                          : order.registerDate ?? "-",
                      'تاریخ ثبت'),
                  Divider(),
                  detailItem(
                      order.registerTime == null ||
                              (order.registerTime?.isEmpty ?? false)
                          ? "-"
                          : order.registerTime ?? "-",
                      'ساعت ثبت'),
                  Divider(),
                  detailItem(
                      order.carSwapComment == null ||
                              (order.carSwapComment?.isEmpty ?? false)
                          ? "-"
                          : order.carSwapComment ?? "-",
                      'توضیحات تعویض'),
                ],
              ),
            ));
  }



  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
