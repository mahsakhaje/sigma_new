import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/detail_widget.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';

class MySalesOrdersController extends GetxController {
  final RxList<SalesOrders> salesOrders = <SalesOrders>[].obs;
  final RxMap<String, String> reasons = <String, String>{}.obs;
  final RxString selectedReason = ''.obs;
  final RxString reasonId = ''.obs;
  final RxInt turn = 1.obs;
  final RxBool hasComment = false.obs;
  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> commentFormKey = GlobalKey<FormState>();

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

  Future<void> onProposalsPressed(SalesOrders order) async {
    var shouldUpdate = await CustomBottomSheet.show(
        initialChildSize: 0.3,
        context: Get.context!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  print({'idaval': order.id});
                  Get.toNamed(RouteName.track, arguments: {'id': order.id});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('رهگیری',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset('assets/edit.svg')
                  ],
                ),
              ),
              SizedBox(height: 8,),

              Divider(
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 8,),

              InkWell(
                onTap: () async {
                  Get.back(result: false);
                  showMySalesOrdersDialog(Get.context!, order);
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
              SizedBox(height: 8,),

              Divider(
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 8,),

              InkWell(
                onTap: () async {
                  onCancelPressed(order);
                  Get.back(result: true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('لغو سفارش',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset('assets/cancel.svg')
                  ],
                ),
              ),              SizedBox(height: 8,),

              Divider(
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 8,),

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
                    SvgPicture.asset('assets/suggest.svg',height: 22,)
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void showMySalesOrdersDialog(BuildContext context, SalesOrders order) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  detailItem(
                      order.trimColorDescription ?? "", 'رنگ داخل خودرو'),
                  Divider(),
                  detailItem(order.registerDate ?? " ", 'تاریخ ثبت'),
                  Divider(),
                  detailItem(order.chassisNumber ?? " ", 'شماره شاسی'),
                  Divider(),
                  detailItem(order.registerTime ?? " ", 'ساعت ثبت'),
                  Divider(),
                  detailItem(
                      order.state == "RECEPTION"
                          ? order.timespanDate ?? "پذیرش نشده"
                          : "پذیرش نشده",
                      'تاریخ پذیرش'),
                  Divider(),
                  detailItem(
                      order.state == "RECEPTION"
                          ? order.timespanDateDescription ?? "پذیرش نشده"
                          : "پذیرش نشده",
                      'ساعت پذیرش'),
                  Divider(),
                  detailItem(order.showRoomName ?? "", 'محل مراجعه'),
                  Divider(),
                  detailItem(order.showRoomAddress ?? "", 'آدرس محل مراجعه',isRtl: true),
                ],
              ),
            ));
  }

  Future<void> loadInitialData() async {
    await getData();
    isLoading.value = false;
  }

  Future<void> getData() async {
    pn.value++;
    var response = await DioClient.instance
        .getAccountsSalesOrder(pl: pl.value, pn: pn.value);

    if (response != null) {
      if (pn.value == 1) {
        salesOrders.value = response.salesOrders ?? [];
      } else {
        salesOrders.addAll(response.salesOrders ?? []);
      }
      total.value = int.tryParse(response.count ?? '0') ?? 0;
    }

    hasMore.value = total.value != salesOrders.length;
    print(total.value);
    print(salesOrders.length);
  }

  void reset() {
    pn.value = 0;
    total.value = 0;
    hasMore.value = true;
    salesOrders.clear();
    isLoading.value = true;
  }

  Future<void> refreshData() async {
    reset();
    await getData();
    isLoading.value = false;
  }

  Future<void> onCancelPressed(SalesOrders order) async {
    if (order.state != 'REGISTERED' && order.state != 'CONFIRMED_ORDER') {
      showToast(ToastState.ERROR, 'باتوجه به وضعیت سفارش امکان لغو وجود ندارد');
      return;
    }

    await _loadCancelReasons();
    if (reasons.isEmpty) {
      showToast(ToastState.ERROR, 'خطا در دریافت اطلاعات');
      return;
    }

    _showCancelDialog(order);
  }

  Future<void> _loadCancelReasons() async {
    var response = await DioClient.instance.getCancelReasons();

    reasonId.value = '';
    commentController.text = '';
    hasComment.value = false;
    selectedReason.value = '';
    reasons.clear();

    if (response != null) {
      response.cancelReasons?.forEach((element) {
        reasons[element.id!] = element.description ?? "";
      });
    }
  }

  void _showCancelDialog(SalesOrders order) {
    Get.dialog(
      AlertDialog(
        content: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDropdown(
                  hint: 'علت لغو',
                  isDark: true,
                  isTurn: turn.value == 1,
                  value: selectedReason.value.isEmpty
                      ? null
                      : selectedReason.value,
                  items: reasons,
                  onChanged: (String? str) {
                    selectedReason.value = str ?? "";
                    _updateReasonSelection(str);
                  },
                ),
                SizedBox(height: 16),
                if (hasComment.value)
                  Form(
                    key: commentFormKey,
                    child: CustomTextFormField(
                      commentController,

                      maxLen: 200,
                      isDark: true,
                      acceptAll: true,
                      hintText: 'توضیحات',
                      onChanged: (String val) {},
                    ),
                  ),
                SizedBox(height: 16),
                CustomText('آیا از لغو کردن اطمینان دارید؟',
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ConfirmButton(
                        () => Get.back(),
                        'خیر',
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: ConfirmButton(
                        () => _confirmCancel(order),
                        'بله',
                        borderRadius: 8,
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  void _updateReasonSelection(String? str) async {
    var response = await DioClient.instance.getCancelReasons();
    reasons.forEach((key, value) {
      if (key == str) {
        reasonId.value = key;
        response?.cancelReasons?.forEach((element) {
          if (element.id == reasonId.value) {
            hasComment.value = element.hasComment == '1';
          }
        });
      }
    });

    turn.value = 2;
  }

  Future<void> _confirmCancel(SalesOrders order) async {
    if (reasonId.value.isEmpty) {
      showToast(ToastState.INFO, 'لطفا دلیل لغو درخواست را انتخاب نمایید');
      return;
    }

    if (!hasComment.value ||
        (hasComment.value && commentFormKey.currentState!.validate())) {
      var response = await DioClient.instance.cancelOrder(
        order.id ?? '',
        reasonId.value,
        commentController.text,
      );

      print(response?.message);

      if (response?.message == 'OK') {
        showToast(ToastState.SUCCESS, 'سفارش با موفقیت لغوشد.');
        await Future.delayed(
          Duration(milliseconds: 500),
          () => Get.back(),
        );
        await refreshData();
      } else if (response?.message == 'INVALID_STATE') {
        showToast(ToastState.ERROR,
            'با توجه به وضعیت سفارش امکان لغو آن وجود ندارد.');
        Get.back();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    commentController.dispose();
    super.onClose();
  }
}
