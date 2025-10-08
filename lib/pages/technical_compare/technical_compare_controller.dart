import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/models/car_type_spec_type.dart';

class TechnicalCompareController extends GetxController {
  String firstId;
  String secondId;

  TechnicalCompareController({required this.firstId, required this.secondId});

  var firstCarSpecs = <CarTypeSpecTypes?>[].obs;
  var firstCarEquipments = <String?>[].obs;

  var secondCarSpecs = <CarTypeSpecTypes?>[].obs;
  var secondCarEquipments = <String?>[].obs;

  var isGettingCarInfo = true.obs;

  @override
  void onInit() {
    _getCarsInfo();
    super.onInit();
  }

  Future<void> _getCarsInfo() async {
    await Future.wait([
      getFirstCarSpecTypes(),
      getFirstCarEquipments(),
      getSecondCarSpecTypes(),
      getSecondCarEquipments()
    ]);
  }

  Future<void> getFirstCarSpecTypes() async {
    isGettingCarInfo.value = true;
    var response = await DioClient.instance.getCarSpecTypes(firstId);
    isGettingCarInfo.value = false;
    if (response?.message == 'OK') {
      firstCarSpecs.value = response?.carTypeSpecTypes ?? [];
    } else {
      showToast(ToastState.ERROR, 'خطا در دریافت اطلاعات');
    }
  }

  Future<void> getFirstCarEquipments() async {
    isGettingCarInfo.value = true;
    var response = await DioClient.instance.getCarEquipments(firstId);
    isGettingCarInfo.value = false;
    if (response?.message == 'OK') {
      firstCarEquipments.value = response?.equipments ?? [];
    } else {
      showToast(ToastState.ERROR, 'خطا در دریافت اطلاعات');
    }
  }

  Future<void> getSecondCarSpecTypes() async {
    isGettingCarInfo.value = true;
    var response = await DioClient.instance.getCarSpecTypes(secondId);
    isGettingCarInfo.value = false;
    if (response?.message == 'OK') {
      secondCarSpecs.value = response?.carTypeSpecTypes ?? [];
    } else {
      showToast(ToastState.ERROR, 'خطا در دریافت اطلاعات');
    }
  }

  Future<void> getSecondCarEquipments() async {
    isGettingCarInfo.value = true;
    var response = await DioClient.instance.getCarEquipments(secondId);
    isGettingCarInfo.value = false;
    if (response?.message == 'OK') {
      secondCarEquipments.value = response?.equipments ?? [];
    } else {
      showToast(ToastState.ERROR, 'خطا در دریافت اطلاعات');
    }
  }
}
