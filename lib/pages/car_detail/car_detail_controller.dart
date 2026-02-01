import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/car_detail_response.dart';
import 'package:sigma/models/experties.dart';
import 'package:sigma/pages/technical_menu/technicalInfro_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class CarDetailController extends GetxController {
  final String carId;

  CarDetailController({required this.carId});

  // Observables
  final RxBool isLoading = false.obs;
  final RxBool isDownloading = false.obs;
  final RxBool isExpertLoading = false.obs;
  final RxInt activePage = 0.obs;
  final RxBool isAdvertised = true.obs;
  final RxString errorMessage = ''.obs;

  // Data
  final Rx<SalesOrder?> saleOrder = Rx<SalesOrder?>(null);
  final RxList<String> specCategoryNames = <String>[].obs;
  final RxList<CarTypeDefaultSpecTypes> carSpecs =
      <CarTypeDefaultSpecTypes>[].obs;

  // Computed properties
  bool get hasError => errorMessage.isNotEmpty;

  bool get hasData => saleOrder.value != null;

  List<String> get images {
    if (saleOrder.value?.salesOrderDocuments == null) return [];
    return saleOrder.value!.salesOrderDocuments!
        .map((doc) => '${URLs.imageLinks}${doc.docId}')
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCarDetails();
  }

  Future<void> fetchCarDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await DioClient.instance.getCarDetail(id: carId);

      if (response?.message == 'OK' && response?.salesOrder != null) {
        saleOrder.value = response!.salesOrder;
        isAdvertised.value =
            saleOrder.value?.advertised?.contains('1') ?? false;
        carSpecs.value = saleOrder.value?.carTypeDefaultSpecTypes ?? [];
        _updateSpecCategories();
      } else {
        errorMessage.value = 'خطا در دریافت اطلاعات';
      }
    } catch (e) {
      errorMessage.value = 'خطا در دریافت اطلاعات';
    } finally {
      isLoading.value = false;
    }
  }

  void _updateSpecCategories() {
    specCategoryNames.clear();
    for (var spec in carSpecs) {
      final groupDescription = spec.specGroupDescription ?? '';
      if (groupDescription.isNotEmpty &&
          !specCategoryNames.contains(groupDescription)) {
        specCategoryNames.add(groupDescription);
      }
    }
  }

  Future<void> showExpertSummary() async {
    var response = await DioClient.instance.showExpertSummary(carId.toString());
    if (response?.message == 'OK') {
      showExpertiseDialog(response);
    }
  }

  void showExpertiseDialog(ExpertiseResponse? data) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // عنوان
              CustomText(
                'بررسی کلی وضعیت خودرو',
                color: Colors.black,
                size: 18,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 20),

              // آیتم‌ها
              _buildExpertiseItem(
                  data?.itemTypes1 ?? '', data?.type1IsOk ?? ''),
              SizedBox(height: 12),
              _buildExpertiseItem(
                  data?.itemTypes2 ?? '', data?.type2IsOk ?? ''),
              SizedBox(height: 12),
              _buildExpertiseItem(
                  data?.itemTypes3 ?? '', data?.type3IsOk ?? ""),
              SizedBox(height: 12),
              _buildExpertiseItem(
                  data?.itemTypes4 ?? '', data?.type4IsOk ?? ''),
              SizedBox(height: 12),
              _buildExpertiseItem(
                  data?.itemTypes5 ?? '', data?.type5IsOk ?? ""),
              SizedBox(height: 12),
              _buildExpertiseItem(
                  data?.itemTypes6 ?? '', data?.type6IsOk ?? ''),

              SizedBox(height: 20),

              ConfirmButton(() => downloadExpertPdf(), 'دانلود برگه کارشناسی')
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildExpertiseItem(String text, String isOk) {
    bool isValid = isOk == "1";

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isValid
            ? Color.fromRGBO(226, 255, 247, 1)
            : Color.fromRGBO(255, 231, 231, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isValid
              ? Color.fromRGBO(0, 150, 109, 1)
              : Color.fromRGBO(237, 46, 46, 1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              text,
              isRtl: true,
              color: Colors.black,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 12),
          SvgPicture.asset(isValid ? 'assets/okgreen.svg' : 'assets/nokey.svg'),
        ],
      ),
    );
  }

  Future<void> downloadExpertPdf() async {
    try {
      showToast(ToastState.INFO, 'لطفا منتظر بمانید');

      isExpertLoading.value = true;
      final response =
          await DioClient.instance.getExpertReportInCarDetail(carId.toString());


      if (response != null) {
        // Check if response contains error message
        if (response.contains('فایل') && response.contains('خطا')) {
          showToast(ToastState.ERROR, 'خطا در نمایش فایل');
        } else {
          // Response should be the full file path
          showToast(ToastState.SUCCESS, 'با موفقیت ذخیره شد');

          // Verify file exists before trying to open
          final file = File(response);
          if (await file.exists()) {
            await OpenFile.open(response);
          } else {
            showToast(ToastState.ERROR, 'فایل یافت نشد');
          }
        }
      } else {
        showToast(ToastState.ERROR, 'خطا در دریافت فایل');
      }
    } catch (e) {
      showToast(ToastState.ERROR, 'خطا در دانلود فایل');
    } finally {
      isExpertLoading.value = false;
    }
  }

  Future<void> downloadCatalog() async {
    try {
      showToast(ToastState.INFO, 'لطفا منتظر بمانید');

      isDownloading.value = true;
      final catalogUrl = saleOrder.value?.catalogUrl;

      if (catalogUrl != null) {
        // Download the file instead of launching URL
        final filePath =
            await DioClient.instance.downloadFileFromUrl(catalogUrl, 'catalog');

        if (filePath != null) {
          showToast(ToastState.SUCCESS, 'با موفقیت ذخیره شد');
          await OpenFile.open(filePath);
        } else {
          showToast(ToastState.ERROR, 'خطا در دانلود فایل');
        }
      } else {
        showToast(ToastState.ERROR, 'لینک فایل یافت نشد');
      }
    } catch (e) {
      showToast(ToastState.ERROR, 'خطا در دانلود فایل');
    } finally {
      isDownloading.value = false;
    }
  }

  void showSpecypes() {}

  void onPageChanged(int page) {
    activePage.value = page;
  }

  void navigateToComparison() {
    Get.toNamed(RouteName.compare_car, arguments: carId);
  }

  void navigateToReservation() {
    Get.toNamed(RouteName.reserveShowRoom, arguments: {'id': carId});
  }
}
