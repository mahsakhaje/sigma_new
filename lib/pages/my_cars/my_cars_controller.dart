import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/models/my_cars_model.dart';
import 'package:sigma/models/my_purchase_order_response.dart';

class MyCarsController extends GetxController {
  final RxList<Cars> cars = <Cars>[].obs;
  final RxInt pn = 0.obs;
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
    var response =
        await DioClient.instance.getMycars(pl: pl.value, pn: pn.value);
    isLoading.value = false;
    if (response != null) {
      if (pn.value == 1) {
        cars.value = response.cars ?? [];
      } else {
        cars.addAll(response.cars ?? []);
      }
      total.value = int.tryParse(response.count ?? '0') ?? 0;
    }

    hasMore.value = total.value != cars.length;
  }

  void reset() {
    pn.value = 0;
    total.value = 0;
    hasMore.value = true;
    cars.clear();
    isLoading.value = true;
  }

  Future<void> refreshData() async {
    reset();
    await getData();
    isLoading.value = false;
  }

  Future<void> onProposalsPressed(Cars order) async {
    var shouldUpdate = await CustomBottomSheet.show(
        initialChildSize: 0.3,
        context: Get.context!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextButton(
                onPressed: order.editable == '1'
                    ? () async {
                        await Get.toNamed(RouteName.car, arguments: order);
                        reset();
                        await getData();
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('ویرایش',
                        color:
                            order.editable == '1' ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/edit.svg',
                      color: order.editable == '1' ? Colors.black : Colors.grey,
                    )
                  ],
                ),
              ),
              Divider(
                color: AppColors.lightGrey,
              ),
              TextButton(
                onPressed: () async {
                _showDeleteDialog(order);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('حذف خودرو',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset('assets/trash.svg')
                  ],
                ),
              ),
              Divider(
                color: AppColors.lightGrey,
              ),
              TextButton(
                onPressed: order.editable == '1'
                    ? () {
                        Get.toNamed(RouteName.sell,
                            arguments: {'id': order.id});
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('ادامه فروش',
                        color:
                            order.editable == '1' ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset('assets/continue.svg',
                        color:
                            order.editable == '1' ? Colors.black : Colors.grey)
                  ],
                ),
              ),
            ],
          ),
        ));
    if (shouldUpdate) {
      reset();
      await getData();
    }
  }
  void _showDeleteDialog(Cars order) {
    Get.dialog(
      AlertDialog(
        title: Container(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'آیا از حذف خودرو مطمئن هستید؟'
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
                        () => _confirmDelete(order),
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

  void onDetailsPressed(Cars order) {
    // showMyBuyDetailDialog(Get.context!, order);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  _confirmDelete(Cars order) async{
    var response =
        await DioClient.instance.deleteCar(id: order.id ?? '');
    if (response?.message == 'OK') {
      Future.delayed(
          Duration(milliseconds: 500),
              () => {
            showToast(ToastState.SUCCESS, ' با موفقیت حذف شد')
          });

      Get.back(result: true);
    }
    if (response?.message == 'INVALID_STATE') {
      showToast(ToastState.ERROR, 'امکان حذف وجود ندارد');
    }
    Get.back(result: true);
  }
}
