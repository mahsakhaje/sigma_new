import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/notif_list_response.dart';

class NotifController extends GetxController {
  var accountNotifs = <AccountNotifs>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
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
    await DioClient.instance.setSeenNotifs();
    var response = await DioClient.instance.getNotifList();
    isLoading.value = false;
    if (response?.message == 'OK') {
      accountNotifs.value = response?.accountNotifs ?? [];
    } else {
      hasError.value = true;
    }
  }
}
