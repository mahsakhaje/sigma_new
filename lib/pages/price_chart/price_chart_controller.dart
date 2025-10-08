import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/change_price_model.dart';

class PriceChartController extends GetxController {
  final RxList<YearData> yearDataList = <YearData>[].obs;
  final RxBool isLoading = true.obs;
  final String id;
  final RxString error = ''.obs;
  final List<int> years = [1402, 1403, 1404];
  final List<Color> yearColors = [
    AppColors.blue,
    AppColors.orangeChart,
    AppColors.greenChart,
  ];

  PriceChartController({required this.id});

  @override
  void onInit() async {
    await getAllPricesChange();
    super.onInit();
  }

  Future<void> getAllPricesChange() async {
    try {
      isLoading.value = true;

      // فقط یک بار API را صدا می‌زنیم
      var response = await DioClient.instance.getPriceChange(id, '');

      if (response?.message == 'OK') {
        final List<YearData> tempYearDataList = [];

        // داده‌های سال 1402
        if (response?.prices1402 != null) {
          tempYearDataList.add(YearData(
            year: 1402,
            data: response?.prices1402?.toChartDataList() ?? [],
            color: yearColors[0],
          ));
        }

        // داده‌های سال 1403
        if (response?.prices1403 != null) {
          tempYearDataList.add(YearData(
            year: 1403,
            data: response?.prices1403?.toChartDataList() ?? [],
            color: yearColors[1],
          ));
        }

        // داده‌های سال 1404
        if (response?.prices1404 != null) {
          tempYearDataList.add(YearData(
            year: 1404,
            data: response?.prices1404?.toChartDataList() ?? [],
            color: yearColors[2],
          ));
        }

        yearDataList.assignAll(tempYearDataList);
      }

      isLoading.value = false;
    } catch (e) {
      print('Error loading price data: $e');
      error.value = 'خطا در دریافت اطلاعات';
      isLoading.value = false;
    }
  }
}
