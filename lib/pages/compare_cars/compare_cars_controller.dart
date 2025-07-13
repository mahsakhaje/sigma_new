import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/car_detail_response.dart';

class CompareCarsController extends GetxController {
  final RxBool isLoading = true.obs;
  final Rxn<CarDetailResponse> firstDetail = Rxn<CarDetailResponse>();
  final Rxn<CarDetailResponse> secondDetail = Rxn<CarDetailResponse>();
  final RxList<String> imagesFirst = <String>[].obs;
  final RxList<String> imagesSecond = <String>[].obs;

  late String firstId;
  late String secondId;

  @override
  void onInit() {
    super.onInit();
    final Compare compare = Get.arguments as Compare;
    firstId = compare.firstId;
    secondId = compare.secondId;
    _loadCarDetails();
  }

  Future<void> _loadCarDetails() async {
    try {
      isLoading.value = true;

      final responses = await Future.wait([
        DioClient.instance.getCarDetail(id: firstId),
        DioClient.instance.getCarDetail(id: secondId),
      ]);

      if (responses[0]?.message == 'OK') {
        firstDetail.value = responses[0];
      }
      if (responses[1]?.message == 'OK') {
        secondDetail.value = responses[1];
      }
    } catch (e) {
      Get.snackbar('خطا', 'مشکلی در بارگذاری اطلاعات رخ داده است');
    } finally {
      isLoading.value = false;
    }
  }

  void removeSecondCar() {
    secondDetail.value = null;
  }

  void navigateBack() {
    Get.back();
  }

  String get comparisonTitle {
    final second = secondDetail.value?.salesOrder;
    final first = firstDetail.value?.salesOrder;

    return '${second?.brandDescription ?? ''} ${second?.carModelDescription ?? ''} / ${first?.brandDescription ?? ''} ${first?.carModelDescription ?? ''}';
  }
}
class Compare {
  final String firstId;
  final String secondId;

  const Compare(this.firstId, this.secondId);
}