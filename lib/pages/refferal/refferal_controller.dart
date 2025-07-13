// referral_controller.dart
import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';

class ReferralController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxString referralCode = ''.obs;
  final RxString referralLink = ''.obs;

  @override
  void onInit() {
    fetchUserInfo();
    super.onInit();
  }

  Future<void> fetchUserInfo() async {
    try {
      var userInfo = await DioClient.instance.getUserInfo();
      if (userInfo != null && userInfo.message == 'OK') {
        referralCode.value = (userInfo.account?.refCode ?? '');
        referralLink.value = (userInfo.account?.refLink ?? '');
      }
    } catch (e) {
      // Handle error
      print('Error fetching user info: $e');
    } finally {
      isLoading.value = false;
    }
  }
}



