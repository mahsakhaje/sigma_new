import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/models/all_cars_json_model.dart';
import 'package:sigma/models/car_info_response.dart';
import 'package:sigma/models/my_cars_model.dart';

enum PageState { Estelam, Confirm }

class CarController extends GetxController {
  final shasiController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final firstLoading = true.obs;
  final pageState = PageState.Estelam.obs;
  final isLoading = false.obs;
  final turn = 1.obs;

  final selectedBrand = Rx<String?>(null);
  final selectedCarModel = Rx<String?>(null);
  final selectedCarType = Rx<String?>(null);
  final selectedFromYear = Rx<String?>(null);
  final selectedColors = Rx<String?>(null);
  final selectedTrimColors = Rx<String?>(null);

  final brands = <String, String>{}.obs;
  final carModels = <String, String>{}.obs;
  final carTypes = <String, String>{}.obs;
  final colorsCars = <String, String>{}.obs;
  final trimColors = <String, String>{}.obs;
  final carTypeManufactureYears = <String, String>{}.obs;

  String brandId = '';
  String modelId = '';
  String typeId = '';
  String colorId = '';
  String trimColorId = '';
  String fromYearId = '';

  bool? hasError = false;
  AllCarsJsonModel? allCarsJsonModel;
  Cars? order;

  void init(Cars? car) async {
    order = car;
    print(order);
    if (order != null) {
      pageState.value = PageState.Confirm;
    }
    await loadInitialData();
  }

  Future<void> loadInitialData() async {
    final responseAllCar = await DioClient.instance.getAllCarsJson();
    if (responseAllCar?.message == 'OK') {
      allCarsJsonModel = responseAllCar;
      for (var brand in responseAllCar?.brands ?? []) {
        brands[brand.id!] = brand.description!;
      }
    }

    if (order != null) {
      CarInfoResponse? data =
          await DioClient.instance.getCarInfo(id: order?.id ?? '');
      shasiController.text = order?.chassisNumber ?? '';

      selectedBrand.value = data?.car?.brandId ?? '';
      selectedCarModel.value = data?.car?.carModelId ?? "";
      selectedFromYear.value = data?.car?.manufactureYearId;
      selectedCarType.value = data?.car?.carTypeId ?? '';

      _fillModelTypeColorData();

      selectedTrimColors.value = data?.car?.trimColorId;
      selectedColors.value = data?.car?.colorId;
      colorId = data?.car?.colorId ?? '';
      trimColorId = data?.car?.trimColorId ?? '';
      firstLoading.value = false;

      return;
    }

    brands.forEach((key, value) {
      if (value == selectedBrand.value) brandId = key;
    });
    carTypeManufactureYears.forEach((key, value) {
      if (value == selectedFromYear.value) fromYearId = key;
    });
    carTypes.forEach((key, value) {
      if (value == selectedCarType.value) typeId = key;
    });

    firstLoading.value = false;
  }

  void _fillModelTypeColorData() {
    allCarsJsonModel?.brands?.forEach((brand) {
      if (brand.id == selectedBrand.value) {
        for (var model in brand.carModels ?? []) {
          carModels[model.id!] = model.description!;

          if (model.id == selectedCarModel.value) {
            for (var type in model.carTypes ?? []) {
              carTypes[type.id!] = type.description!;

              if (type.id == selectedCarType.value) {
                for (var color in type.carTypeColors ?? []) {
                  colorsCars[color.colorId ?? ''] = color.color ?? '';
                }
                for (var trim in type.carTypeTrimColors ?? []) {
                  trimColors[trim.colorId ?? ''] = trim.color ?? '';
                }
                for (var year in type.carTypeManufactureYears ?? []) {
                  carTypeManufactureYears[year.manufactureYearId!] =
                      "${year.miladiYear}_${year.persianYear}";
                }
              }
            }
          }
        }
      }
    });
  }

  void onShasiChanged(String val) async {
    if (val.length == 17) {
      hideKeyboard(Get.context!);
      bool response = await DioClient.instance.checkChassiNumber(val) ?? false;
      hasError = !response;
      validate(val);
      turn.value = 2;
    }
  }

  void onBrandChanged(String? str) {
    selectedBrand.value = str ?? '';
    turn.value = 3;
    carModels.clear();
    carTypes.clear();
    allCarsJsonModel?.brands?.forEach((brand) {
      if (brand.id == str) {
        for (var model in brand.carModels ?? []) {
          carModels[model.id!] = model.description!;
        }
      }
    });
    brands.forEach((key, value) {
      if (value == selectedBrand.value) brandId = key;
    });
    selectedCarModel.value = null;
    selectedCarType.value = null;
    selectedFromYear.value = null;
    colorsCars.clear();
    trimColors.clear();
  }

  void onModelChanged(String? str) {

    selectedCarModel.value = str ?? '';
    carModels.forEach((key, value) {
      if (value == str) modelId = key;
    });
    turn.value = 4;
    carTypes.clear();
    allCarsJsonModel?.brands?.forEach((brand) {
      if (brand.id == selectedBrand.value) {
        brand.carModels?.forEach((model) {
          if (model.id == selectedCarModel.value) {
            model.carTypes?.forEach((type) {
              carTypes[type.id!] = type.description!;
            });
          }
        });
      }
    });
    selectedCarType.value = null;
    selectedFromYear.value = null;
    colorsCars.clear();
    trimColors.clear();
    selectedTrimColors.value=null;
    selectedColors.value=null;

  }

  void onTypeChanged(String? str) {
    selectedCarType.value = str ?? '';
    carTypes.forEach((key, value) {
      if (value == str) typeId = key;
    });
    turn.value = 5;
    colorsCars.clear();
    trimColors.clear();
    selectedTrimColors.value=null;
    selectedColors.value=null;
    carTypeManufactureYears.clear();

    allCarsJsonModel?.brands?.forEach((brand) {
      if (brand.id == selectedBrand.value) {
        brand.carModels?.forEach((model) {
          if (model.id == selectedCarModel.value) {
            model.carTypes?.forEach((type) {
              if (type.id == selectedCarType.value) {
                for (var color in type.carTypeColors ?? []) {
                  colorsCars[color.colorId ?? ''] = color.color ?? '';
                }
                for (var trim in type.carTypeTrimColors ?? []) {
                  trimColors[trim.colorId ?? ''] = trim.color ?? '';
                }
                for (var year in type.carTypeManufactureYears ?? []) {
                  carTypeManufactureYears[year.manufactureYearId!] =
                      "${year.miladiYear}_${year.persianYear}";
                }
              }
            });
          }
        });
      }
    });
    selectedFromYear.value = null;
  }

  void onYearChanged(String? str) {
    selectedFromYear.value = str ?? '';
    carTypeManufactureYears.forEach((key, value) {
      if (value == str) fromYearId = key;
    });
    turn.value = 6;
  }

  void onColorChanged(String? str) {
    selectedColors.value = str ?? '';
    colorsCars.forEach((key, value) {
      if (value == str) colorId = key;
    });
    turn.value = 7;
  }

  void onTrimColorChanged(String? str) {
    selectedTrimColors.value = str ?? '';
    trimColors.forEach((key, value) {
      if (value == str) trimColorId = key;
    });
    turn.value = 8;
  }

  String? validate(String? value) {
    if (value?.length == 17) {
      return hasError == true
          ? 'شماره شاسی مربوط به محصولات کرمان موتور نمی باشد'
          : null;
    } else if ((value?.length ?? 0) < 17) {
      return 'شماره شاسی را به صورت صحیح وارد نمایید';
    }
    return null;
  }

  void confirm() async {
    hideKeyboard(Get.context!);
    if( shasiController.text.length!=17){
      showToast(ToastState.ERROR, 'شماره شاسی وارد شده صحیح نیست!');
      return;
    }
    if (formKey.currentState?.validate() ?? true) {
      if ([
            selectedBrand,
            selectedCarType,
            selectedColors,
            selectedTrimColors,
            selectedFromYear
          ].every((e) => e.value?.isNotEmpty ?? false) &&
          shasiController.text.isNotEmpty) {
        final response = order == null
            ? await DioClient.instance.addNewCar(
                trimColorId: selectedTrimColors.value ?? "",
                carTypeId: selectedCarType.value ?? "",
                chassisNumber: shasiController.text,
                colorId: selectedColors.value ?? "",
                manufactureYearId: selectedFromYear.value ?? "")
            : await DioClient.instance.updateNewCar(
                id: order?.id ?? '',
                trimColorId: selectedTrimColors.value ?? "",
                carTypeId: selectedCarType.value ?? "",
                chassisNumber: shasiController.text,
                colorId: selectedColors.value ?? "",
                manufactureYearId: selectedFromYear.value ?? "");

        if (response?.message == 'OK') {
          showToast(
              ToastState.SUCCESS,
              order == null
                  ? 'با موفقیت افزوده شد'
                  : 'با موفقیت به روزرسانی شد');
          Get.back();
        }
      } else {
        showToast(ToastState.INFO, 'لطفا تمامی موارد را تکمیل نمایید');
      }
    }
  }

  void inquiry() async {
    if (shasiController.text.length==17) {
      isLoading.value = true;
      final response = await DioClient.instance.getInquiryChassisNumber(
        chassisNumber: shasiController.text,
      );
      isLoading.value = false;

      if (response?.status == 0) {
        print(brands.entries);

        brandId = response?.brandId ?? '';
        print(brandId);
        print(brands[brandId] ?? '');
        modelId = response?.carModelId ?? '';
        typeId = response?.carTypeId ?? '';
        colorId = response?.colorId ?? '';
        trimColorId = response?.trimColorId ?? '';
        fromYearId = response?.manufactureYearId ?? '';

        selectedBrand.value = brandId ?? '';
        selectedCarModel.value = modelId ?? '';
        selectedCarType.value =typeId ?? '';

        _fillModelTypeColorData();

        selectedFromYear.value = fromYearId ?? '';
        selectedColors.value = colorId ?? '';
        selectedTrimColors.value = trimColorId ?? '';

        pageState.value = PageState.Confirm;
      } else { await Get.dialog(AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              'کاربر گرامی متاسفانه اطلاعات خودروی شما در بانک اطلاعات کرمان موتور یافت نشد.',
              color: Colors.black87,
              isRtl: true,
              size: 15,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 12),
            CustomText('لطفا اطلاعات خودروی خود را وارد نمائید.',
                color: Colors.black87, size: 14, isRtl: true),
            SizedBox(height: 34),
            ConfirmButton(() {
              Get.back();
              pageState.value = PageState.Confirm;
            }, 'تایید', borderRadius: 8, fontSize: 12)
          ],
        ),
      ));

      }
    }else{
      showToast(ToastState.ERROR, 'شماره شاسی وارد شده صحیح نمی باشد.');
    }
  }
}
