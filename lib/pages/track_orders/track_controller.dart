import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/models/tracking_sales_model.dart';

class TrackingSalesOrderController extends GetxController {
  final String orderId;

  TrackingSalesOrderController({required this.orderId});

  // Reactive variables
  final _orderStep = 0.obs;
  final _loading = true.obs;
  final Rx<TrackingSalesOrderResponse?> _trackingSalesOrderResponse = Rx<TrackingSalesOrderResponse?>(null);

  // Getters
  int get orderStep => _orderStep.value;
  bool get loading => _loading.value;
  TrackingSalesOrderResponse? get trackingSalesOrderResponse => _trackingSalesOrderResponse.value;

  @override
  void onInit() {
    super.onInit();
    _loadTrackingData();
  }

  Future<void> _loadTrackingData() async {
    try {
      _loading.value = true;
      _trackingSalesOrderResponse.value = await DioClient.instance.trackSalesOrder(id: orderId);
      _orderStep.value = int.tryParse(_trackingSalesOrderResponse.value?.step ?? '0') ?? 0;
    } catch (e) {
      // Handle error
      Get.snackbar('خطا', 'خطا در بارگذاری اطلاعات');
    } finally {
      _loading.value = false;
    }
  }

  Future<void> downloadExpertReport() async {
    try {
      var response = await DioClient.instance.getExpertReportInTracking(
          _trackingSalesOrderResponse.value?.expertOrderId ?? ""
      );

      if (response != null) {
        if (response.contains('فایل')) {
          showToast(ToastState.ERROR, 'خطا در نمایش فایل');
          return;
        }
        showToast(ToastState.SUCCESS, 'با موفقیت ذخیره شد');
        await OpenFile.open(response);
      }
    } catch (e) {
      showToast(ToastState.ERROR, 'خطا در دانلود گزارش');
    }
  }

  void showStepInfo(int step) {
    final response = _trackingSalesOrderResponse.value;
    if (response == null) return;

    String title;
    List<MapEntry<String, String?>> details = [];

    switch (step) {
      case 1:
        title = 'ثبت سفارش';
        details = [
          MapEntry('تاریخ ثبت', response.registerDate),
          MapEntry('شماره سفارش', response.orderNumber),
          MapEntry('تاریخ مراجعه', response.timespanDate),
          MapEntry('ساعت مراجعه', response.timespanTime),
          MapEntry('محل مراجعه', response.showRoomAddress),
        ];
        break;
      case 2:
        title = 'پذیرش';
        details = [
          MapEntry('تاریخ مراجعه', response.timespanDate),
          MapEntry('ساعت مراجعه', response.timespanTime),
          MapEntry('نام محل مراجعه', response.showRoomName),
          MapEntry('محل مراجعه', response.showRoomAddress),
        ];
        break;
      case 3:
        title = 'کارشناسی';
        details = [
          MapEntry('تاریخ کارشناسی', response.expertDate),
          MapEntry('کارشناس مربوطه', response.expertUser),
        ];
        break;
      case 4:
        title = 'قیمت گذاری';
        details = [
          MapEntry('تاریخ قیمت گذاری', response.expertPriceDate),
          MapEntry('قیمت', (response.expertPriceAmount?.seRagham()??'0')+'تومان'),
        ];
        break;
      case 5:
        title = 'ثبت آگهی';
        details = [
          MapEntry('تاریخ ثبت آگهی', response.advertiseDate),
          MapEntry('ساعت ثبت آگهی', response.advertiseTime),
          MapEntry('قیمت آگهی', (response.advertiseAmount?.seRagham()??'0')+'تومان'),
        ];
        break;
      case 6:
        title = 'ثبت قرارداد';
        details = [
          MapEntry('تاریخ ثبت قرارداد', response.contractDate),
          MapEntry('ساعت ثبت قرارداد', response.contractTime),
          MapEntry('قیمت توافق شده', (response.contractAmount?.seRagham()??'0')+'تومان'),
          MapEntry('محل پارک خودرو', response.contractParkingAddress),
        ];
        break;
      case 7:
        title = 'تایید قرارداد';
        details = [
          MapEntry('شماره قرارداد', response.contractNumber),
          MapEntry('تاریخ تایید قرارداد', response.contractConfirmDate),
          MapEntry('ساعت تایید قرارداد', response.contractConfirmTime),
        ];
        break;
      default:
        return;
    }

    Get.dialog(
      AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              size: 16,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(color: Colors.black),
            SizedBox(height: 10),
            ...details.where((detail) => detail.key.isNotEmpty && detail.value != null)
                .map((detail) => _buildDetailRow(detail.key, detail.value!)),
            SizedBox(height: 10),
            if (title == 'کارشناسی')
              ConfirmButton(
                    () async {
                  Get.back(); // Close dialog first
                  await downloadExpertReport();
                },
                'مشاهده گزارش',

              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String desc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(minHeight: 30),
            child: CustomText(
              desc.usePersianNumbers(),
              color: Colors.black,
              maxLine: 4,
              isRtl: true
            ),
          ),
        ),
        SizedBox(
          height: 30,
          width: 8,
          child: CustomText(':', color: Colors.black),
        ),
        SizedBox(
          height: 30,
          child: CustomText(title, color: Colors.black),
        ),
      ],
    );
  }
}