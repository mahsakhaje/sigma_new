import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';
import 'package:sigma/pages/compare_cars/compare_cars_controller.dart';

class CompareAdvertiseController extends GetxController {
  CompareAdvertiseController(String compareCarId) : compareCarId = compareCarId;

  final String compareCarId;
  final RxList<SalesOrders> orders = <SalesOrders>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt pl = 5.obs;
  final RxInt pn = 0.obs;
  final RxInt total = 0.obs;
  final scrollController = ScrollController();
  var isFetchingMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          hasMore.value &&
          !isFetchingMore.value) {
        getOrders();
      }
    });
    loadInitialData();
  }

  void handleCarItemTap(String carId) {
    // فقط اگر آیدی با _compareCarId متفاوت باشد، به صفحه مقایسه برود
    if (carId != compareCarId) {
      Get.toNamed(RouteName.compare,
          arguments: Compare(
            compareCarId,
            carId,
          ));
    }
  }

  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;
      await getOrders();
    } catch (e) {
      print('Error loading initial data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOrders() async {
    try {
      if (isFetchingMore.value) return;
      isFetchingMore.value = true;
      isLoading.value = true;
      pn.value++;

      var response = await DioClient.instance.getSalesOrdersWithFilter(
        brandId: '',
        carModelId: '',
        carTypeIds: '',
        carTypeId: '',
        colorId: '',
        fromAmount: '',
        toAmount: '',
        cityIds: '',
        cityId: '',
        state: '',
        fromYear: '',
        toYear: '',
        pl: pl.value,
        pn: pn.value,
      );

      if (response?.message == 'OK') {
        if (pn.value == 1) {
          orders.clear();
        }

        if (response?.salesOrders != null) {
          orders.addAll(response!.salesOrders!);
        }
        total.value = int.tryParse(response?.count ?? '0') ?? 0;
        hasMore.value = (orders.length) != total.value;
      }
    } catch (e) {
      print('Error getting orders: $e');
    } finally {
      isLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  void reset() {
    pn.value = 0;
    orders.clear();
    hasMore.value = true;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}