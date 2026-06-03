import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/payments_model.dart';

class PaymentsController extends GetxController {
  var payments = <Payment>[].obs;
  var loading = true.obs;

  @override
  void onInit() {
    getPaymentsList();
    super.onInit();
  }

  Future<void> getPaymentsList() async {
    var response = await DioClient.instance.getPayments();
    loading.value=false;
    print(response);
    if (response?.message == 'OK') {
      payments.value = response?.payments ?? [];
    }
  }
}
