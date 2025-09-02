import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';

class HomeController extends GetxController {
  var unreadCount = 0.obs;

  @override
  void onInit() {
    fetchNotifs();
    super.onInit();
  }

  Future<void> fetchNotifs() async {

    var responseCount = await DioClient.instance.getNotifCount();
    if (responseCount?.message == 'OK') {
      unreadCount.value = int.tryParse(responseCount?.text ?? '0') ?? 0;
    }
  }
  @override
  void onReady() {
    fetchNotifs();
    super.onReady();
  }
}
