import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/notif_list_response.dart';

class HomeController extends GetxController {
  var unreadCount = 0.obs;
  var accountNotifs = <AccountNotifs>[].obs;

  //var hasNewEtelaie = false.obs;
  var hasNewNotidf = false.obs;

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
    var response = await DioClient.instance.getInfo();
    if (response?.message == 'OK') {
      response?.infos?.forEach((info) {
        if (info.enable == '1') {
          hasNewNotidf.value = true;
          return;
        }
      });
    }
  }

  @override
  void onReady() {
    fetchNotifs();
    super.onReady();
  }
}
