import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';

class AboutUsController extends GetxController {
  var aboutUs = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAboutUs();
  }

  Future<void> fetchAboutUs() async {
    var rules = await DioClient.instance.getAboutUs();
    if (rules != null) {
      aboutUs.value = rules.aboutUs?.content ?? '';
    }
    isLoading.value = false;
  }
}
