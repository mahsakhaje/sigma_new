import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/car_detail_response.dart';
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

  Future<void> downloadExpertPdf() async {
    try {
      showToast(ToastState.INFO, 'لطفا منتظر بمانید');

      isExpertLoading.value = true;
      final response = await DioClient.instance.getExpertReport(carId.toString());

      print('Response: $response');

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
      print('Download error: $e');
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
      print('Catalog URL: $catalogUrl');

      if (catalogUrl != null) {
        // Download the file instead of launching URL
        final filePath = await DioClient.instance.downloadFileFromUrl(catalogUrl, 'catalog');

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
      print('Download error: $e');
      showToast(ToastState.ERROR, 'خطا در دانلود فایل');
    } finally {
      isDownloading.value = false;
    }
  }

  void onPageChanged(int page) {
    activePage.value = page;
  }

  void navigateToComparison() {
    Get.toNamed(RouteName.compare_car, arguments:  carId);
  }

  void navigateToReservation() {
    Get.toNamed(RouteName.reserveShowRoom, arguments: {'id': carId});
  }
}
