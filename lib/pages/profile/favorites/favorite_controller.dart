import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';

class FavoritesController extends GetxController {
  var isLoading = true.obs;
  var orders = <SalesOrders>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  Future<void> getOrders() async {
    isLoading.value = true;
    var response = await DioClient.instance.getFavourites();

    if (response == null || response.message != 'OK') {
      Get.snackbar('خطا', 'خطا در دریافت اطلاعات');
      isLoading.value = false;
      return;
    }

    orders.value = response.salesOrders ?? [];
    isLoading.value = false;
  }

  void delete(String id) async {
    // Call delete API if needed
    getOrders();
  }
}
