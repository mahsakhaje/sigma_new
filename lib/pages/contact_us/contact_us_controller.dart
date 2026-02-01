import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';

class ContactUsController extends GetxController {
  var address = Rxn<String>();
  var showRoomAddress = Rxn<String>();
  var telephone = Rxn<String>();
  var supportTelephone = Rxn<String>();
  var messageNumber = Rxn<String>();
  var suggestionNumber = Rxn<String>();
  var email = Rxn<String>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    try {
      final response = await DioClient.instance.getContactUs();
      if (response != null && response.message == 'OK') {
        address.value = response.address;
        showRoomAddress.value = response.showRoomAddress;
        telephone.value = response.telephone;
        supportTelephone.value = response.supportTelephone;
        // حذف تگ‌های HTML
        messageNumber.value = response.messageNumber
            ?.replaceAll('<br>', '\n')
            .replaceAll(RegExp(r'<[^>]*>'), '');
        email.value = response.email;
        suggestionNumber.value = response.suggestionNumber;
        print(showRoomAddress.value);
      }
    } finally {
      isLoading.value = false;
    }
  }
}