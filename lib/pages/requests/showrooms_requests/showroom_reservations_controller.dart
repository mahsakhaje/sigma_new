import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/detail_widget.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/models/my_reservation_model.dart';

class MyReservationsController extends GetxController {
  final RxList<Reservations> reservations = <Reservations>[].obs;
  final RxInt pn = 0.obs;
  final RxInt pl = 10.obs;
  final RxInt total = 0.obs;
  final RxBool hasMore = true.obs;
  final RxBool isLoading = true.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    setupScrollListener();
    loadInitialData();
  }

  void setupScrollListener() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (hasMore.value) {
          await getData();
        }
      }
    });
  }

  Future<void> loadInitialData() async {
    await getData();
    isLoading.value = false;
  }

  Future<void> getData() async {
    pn.value++;
    var response =
        await DioClient.instance.getMyReservations(pn: pn.value, pl: pl.value);

    if (response != null) {
      if (pn.value == 1) {
        reservations.value = response.reservations ?? [];
      } else {
        reservations.addAll(response.reservations ?? []);
      }
      total.value = int.tryParse(response.count ?? '0') ?? 0;
    }

    hasMore.value = total.value != reservations.length;
  }

  void reset() {
    pn.value = 0;
    total.value = 0;
    hasMore.value = true;
    reservations.clear();
    isLoading.value = true;
  }

  Future<void> refreshData() async {
    reset();
    await getData();
    isLoading.value = false;
  }

  Future<void> onRatePressed(Reservations order) async {
    // await navigateToScreen(
    //   Get.context!,
    //   rating,
    //   argument: RatingInfo(
    //     id: order.id ?? "",
    //     comment: order.rateComment,
    //     ratingStateEnum: RatingStateEnum.ShowRoomRating,
    //   ),
    // );
    // await refreshData();
  }

  void onDetailsPressed(Reservations order) {
    //showMyReservationsDetailDialog(Get.context!, order);
  }

  Future<void> onCancelPressed(Reservations order) async {
    if ((order.canceled ?? "") == '1') {
      showToast(ToastState.ERROR, 'قبلا لغو شده است');
      return; // Already canceled, do nothing
    }

    _showCancelDialog(order);
  }

  void _showCancelDialog(Reservations order) {
    Get.dialog(
      AlertDialog(
        title: Container(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'پس از سه بار لغو سفارش دیگر قادر به دریافت نوبت نیستید، آیا از لغو این سفارش مطمئن هستید؟'
                  .usePersianNumbers(),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'Peyda',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ConfirmButton(
                    () => Get.back(),
                    'خیر',
                    borderRadius: 8,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ConfirmButton(
                    () => _confirmCancel(order),
                    'بله',
                    borderRadius: 8,
                    txtColor: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _confirmCancel(Reservations order) async {
    var response = await DioClient.instance.cancelShowRoom(id: order.id ?? "");

    if (response?.message == 'OK') {
      await refreshData();
      Get.back();
    }

    await Future.delayed(
      Duration(milliseconds: 500),
      () => showToast(ToastState.SUCCESS, 'با موفقیت لغو شد'),
    );

    Get.back();
  }

  String getReservationStatus(Reservations order) {
    return (order.canceled ?? "") == '1' ? 'کنسل شده' : 'در انتظار بازدید';
  }

  Color getStatusColor(Reservations order) {
    return (order.canceled ?? "") == '1' ? Colors.red : AppColors.grey;
  }

  bool isCanceled(Reservations order) {
    return (order.canceled ?? "") == '1';
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void showMyReservationsDetailDialog(
      BuildContext context, Reservations order) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  detailItem(order.timespanDate ?? "", 'تاریخ بازدید'),
                  Divider(),
                  detailItem(order.timespanFromHour ?? "", 'ساعت بازدید از'),
                  Divider(),
                  detailItem(order.timespanToHour ?? "", 'ساعت بازدید تا'),
                  Divider(),
                  detailItem(order.unitAddress ?? '-', '  آدرس شوروم',
                      isRtl: true),
                ],
              ),
            ));
  }

  onProposalsPressed(Reservations order) async {
    var shouldChange = await CustomBottomSheet.show(
        initialChildSize: 0.25,
        context: Get.context!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  Get.back(result: false);
                  showMyReservationsDetailDialog(Get.context!, order);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('جزئیات',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset('assets/detail.svg')
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  print('here');
                  onCancelPressed(order);
                  //Get.back(result: true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('لغو درخواست رزرو',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset('assets/cancel.svg')
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  Get.toNamed(RouteName.suggestions);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('انتقادات و پیشنهادات',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/suggest.svg',
                      height: 22,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
