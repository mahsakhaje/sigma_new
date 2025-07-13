import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/application_info_model.dart';

class InfoController extends GetxController {
  var infos = <Infos>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInfos();
  }

  Future<void> fetchInfos() async {
    var response = await DioClient.instance.getInfo();
    if (response?.message == 'OK') {
      infos.value = response?.infos ?? [];
    }
    isLoading.value = false;
  }
}
