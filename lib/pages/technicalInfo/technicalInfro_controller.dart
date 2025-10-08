import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/models/car_type_equipment_model.dart';
import 'package:sigma/models/car_type_spec_type.dart';
import 'package:sigma/models/mana_prices_response.dart';
import 'package:sigma/pages/technicalInfo/car_info_dialog.dart';

import '../../global_custom_widgets/bottom_sheet.dart';

class TechnicalInfoController extends GetxController {
  var isLoading = true.obs;
  final RxList<ManaPrices> manaPrices = <ManaPrices>[].obs;
  final scrollController = ScrollController();
  var carSpecs = <CarTypeSpecTypes?>[].obs;
  var carEquipments = <String?>[].obs;
  var selectedTab = 0.obs;
  var isgettingCarinfo = false.obs;
  var isChooingMode = false.obs;
  String? firstId;
  String? secondId;
  String? firstImagePath;
  String? secondImagePath;
  String? firstCarName;
  String? secondCarName;

  @override
  void onInit() {
    _getCarList();
    super.onInit();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> _getCarList() async {
    var response = await DioClient.instance.getManaPrices();
    isLoading.value = false;

    if (response?.message == "OK") {
      manaPrices.value = response?.manaPrices ?? [];
    } else {
      manaPrices.value = [];
    }
    isLoading.value = false;
  }

  Future<void> getCarSpecTypes(String id) async {
    isgettingCarinfo.value = true;
    var response = await DioClient.instance.getCarSpecTypes(id);
    isgettingCarinfo.value = false;
    if (response?.message == 'OK') {
      carSpecs.value = response?.carTypeSpecTypes ?? [];
    } else {
      showToast(ToastState.ERROR, 'خطا در دریافت اطلاعات');
    }
  }

  Future<void> getCarEquipments(String id) async {
    isgettingCarinfo.value = true;
    var response = await DioClient.instance.getCarEquipments(id);
    isgettingCarinfo.value = false;
    if (response?.message == 'OK') {
      carEquipments.value = response?.equipments ?? [];
    } else {
      showToast(ToastState.ERROR, 'خطا در دریافت اطلاعات');
    }
  }

  void onCarTapped(String id, String imagePath, String carModel) {
    if (firstId==id || !isChooingMode.value) {
      return;
    }
    secondId = id;
    secondImagePath = imagePath;
    secondCarName = carModel;
    isChooingMode.value = false;
    Get.toNamed(RouteName.technicalCompare, arguments: {
      'firstId': firstId,
      'secondId': secondId,
      'firstCarName': firstCarName,
      'firstCarImagePath': firstImagePath,
      'secondcarName': secondCarName,
      'secondcarImagePath': secondImagePath
    });
  }

  void showMoreBottomSheet(String id, String imagePath, String carModel) {
    firstId = id;
    firstImagePath = imagePath;
    firstCarName = carModel;
    CustomBottomSheet.show(
        initialChildSize: 0.2,
        context: Get.context!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  Get.back(result: false);
                  Get.back(result: false);
                  isChooingMode.value = true;

                  //  showMyBuyDetailDialog(Get.context!, order);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('مقایسه خودرو',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        width: 40,
                        child: SvgPicture.asset('assets/compare.svg',height: 22,))
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  Get.toNamed(RouteName.priceChart, arguments: {
                    'id': id,
                    'imagePath': imagePath,
                    'carModel': carModel
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText('نمودار قیمت',
                        color: Colors.black, fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: SvgPicture.asset(
                        'assets/pricechart.svg',
                        height: 22,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void showCarSpecsDialog(
      String carTypeId, String carName, String imagePath) async {
    Get.dialog(
      CarSpecsDialog(
        carTypeId: carTypeId,
        carName: carName,
        imagePath: imagePath,
      ),
      barrierDismissible: true,
    );
    carSpecs.value = [];
    carEquipments.value = [];
    await Future.wait(
        [getCarEquipments(carTypeId), getCarSpecTypes(carTypeId)]);
  }
}
