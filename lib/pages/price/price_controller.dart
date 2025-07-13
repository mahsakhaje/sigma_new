import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/models/PriceItems%20Response.dart';
import 'package:sigma/models/all_cars_json_model.dart';
import 'package:sigma/models/mana_prices_response.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
enum PageState {
  Form,
  CarState,
}

class PricePageController extends GetxController {
  // Tab state
  final RxInt selectedTabIndex = 0.obs;

  // Daily Price tab state
  final RxList<ManaPrices> manaPrices = <ManaPrices>[].obs;
  final RxBool isManaPricesLoading = true.obs;

  // Price Estimation tab state
  final Rx<Map<String, String>> brands = Rx<Map<String, String>>({});
  final Rx<Map<String, String>> carModels = Rx<Map<String, String>>({});
  final Rx<Map<String, String>> carTypes = Rx<Map<String, String>>({});
  final Rx<Map<String, String>> colorsCars = Rx<Map<String, String>>({});
  final Rx<Map<String, String>> carTypeManufactureYears = Rx<Map<String, String>>({});
  final Rx<Map<String, String>> carStatus = Rx<Map<String, String>>({'1': 'رنگ شده', '2': 'رنگ نشده'});
  final Rx<Map<String, String>> carSubTitleStatus = Rx<Map<String, String>>({'1': 'تعویض شده', '2': 'تعویض نشده'});
  final Rx<Map<String, String>> guarantee = Rx<Map<String, String>>({'1': 'دارد', '2': 'ندارد'});

  Rxn<AllCarsJsonModel> responseAllCar = Rxn<AllCarsJsonModel>();
  final RxList<String?> selectedIds = <String?>[].obs;
  final RxInt turn = 1.obs;
  final Rx<PageState> state = PageState.Form.obs;
  final RxString price = ''.obs;
  final RxString lowestPrice = ''.obs;
  final RxString highestPrice = ''.obs;
  final RxString brandId = ''.obs;
  final RxString modelId = ''.obs;
  final RxString typeId = ''.obs;
  final RxString colorId = ''.obs;
  final RxString fromYearId = ''.obs;

  // Observable values for dropdowns
  final Rxn<String> selectedBrand = Rxn<String>();
  final Rxn<String> selectedCarModel = Rxn<String>();
  final Rxn<String> selectedCarType = Rxn<String>();
  final Rxn<String> selectedTypeManufactureYear = Rxn<String>();
  final Rxn<String> selectedFromYear = Rxn<String>();
  final Rxn<String> selectedColors = Rxn<String>();
  final Rxn<String> selectedCarStatus = Rxn<String>();
  final Rxn<String> selectedCarSubTitleStatus = Rxn<String>();
  final Rxn<String> selectedGaurantee = Rxn<String>();

  final Rx<double> maxUsage = 100000.0.obs;
  final Rx<SfRangeValues> kilometerValues = Rx<SfRangeValues>(SfRangeValues(0, 100000));
  final TextEditingController millageController = TextEditingController();

  Rxn<List<PriceItems>> priceItems = Rxn<List<PriceItems>>();
  Rxn<PriceItemsResponse> priceItemsResponse = Rxn<PriceItemsResponse>();
  final Rx<Map<String, String>> selectedIdsMap = Rx<Map<String, String>>({});
  final Rx<Map<String, String>> carStatusDescription = Rx<Map<String, String>>({});
  final RxBool isAllCarsLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchManaPrices();
    fetchAllCarsData();
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // Daily Price tab methods
  Future<void> fetchManaPrices() async {
    isManaPricesLoading.value = true;
    var response = await DioClient.instance.getManaPrices();
    if (response?.message == "OK") {
      manaPrices.value = response?.manaPrices ?? [];
    } else {
      manaPrices.value = [];
    }
    isManaPricesLoading.value = false;
  }

  // Price Estimation tab methods
  Future<void> fetchAllCarsData() async {
    isAllCarsLoading.value = true;
    responseAllCar.value = await DioClient.instance.getAllCarsJson();

    if (responseAllCar.value?.message == 'OK') {
      Map<String, String> brandsMap = {};
      responseAllCar.value?.brands?.forEach((element) {
        brandsMap[element.id!] = element.description!;
      });
      brands.value = brandsMap;
    }

    isAllCarsLoading.value = false;
    fetchPriceItems();
  }

  Future<void> fetchPriceItems() async {
    priceItemsResponse.value = await DioClient.instance.getPriceItems();
  }

  void updateBrand(String? str) {

    if (str == null) return;

    selectedBrand.value = str;
    turn.value = 2;

    String tempBrandId = '';
    brands.value.forEach((key, value) {
      if (value == str) {
        tempBrandId = key;
      }
    });
    brandId.value = tempBrandId;

    // Clear dependent fields
    priceItems.value = [];
    colorsCars.value = {};
    selectedColors.value = null;

    // Update car models
    Map<String, String> modelsMap = {};
    responseAllCar.value?.brands?.forEach((element) {

      if (element.id == str) {
        print(str);
        print(element.description);
        element.carModels?.forEach((element) {
          modelsMap[element.id!] = element.description!;
        });
      }
    });
    carModels.value = modelsMap;

    // Reset dependent selections
    selectedCarModel.value = null;
    selectedCarType.value = null;
    selectedFromYear.value = null;
  }

  void updateCarModel(String? str) {
    if (str == null) return;

    selectedCarModel.value = str;

    String tempModelId = '';
    carModels.value.forEach((key, value) {
      if (value == str) {
        tempModelId = key;
      }
    });
    modelId.value = tempModelId;

    // Clear dependent fields
    priceItems.value = [];
    turn.value = 3;
    colorsCars.value = {};
    selectedColors.value = null;

    // Update car types
    Map<String, String> typesMap = {};
    responseAllCar.value?.brands?.forEach((element) {
      if (element.id == selectedBrand.value) {
        element.carModels?.forEach((element) {
          if (element.id == str) {
            element.carTypes?.forEach((element) {
              typesMap[element.id!] = element.description!;
            });
          }
        });
      }
    });
    carTypes.value = typesMap;

    // Reset dependent selections
    selectedCarType.value = null;
    selectedFromYear.value = null;
  }

  void updateCarType(String? str) {
    if (str == null) return;

    selectedCarType.value = str;

    // Update typeId
    String tempTypeId = '';
    carTypes.value.forEach((key, value) {
      if (value == str) {
        tempTypeId = key;
      }
    });
    typeId.value = tempTypeId;

    // Clear dependent fields
    colorsCars.value = {};
    turn.value = 4;
    selectedColors.value = null;
    carTypeManufactureYears.value.clear();
    priceItems.value = [];

    // Update colors and manufacture years
    Map<String, String> colorsMap = {};
    Map<String, String> yearsMap = {};

    responseAllCar.value?.brands?.forEach((element) {
      if (element.id == selectedBrand.value) {
        element.carModels?.forEach((element) {
          if (element.id == selectedCarModel.value) {
            element.carTypes?.forEach((element) {
              if (element.id == str) {
                element.carTypeColors?.forEach((element) {
                  colorsMap[element.colorId ?? ''] = element.color ?? '';
                });

                element.carTypeManufactureYears?.forEach((element) {
                  yearsMap[element.manufactureYearId!] =
                      "${element.miladiYear ?? ''}_${element.persianYear ?? ''}";
                });
              }
            });
          }
        });
      }
    });

    colorsCars.value = colorsMap;
    carTypeManufactureYears.value = yearsMap;
    selectedFromYear.value = null;

    // Update price items
    List<PriceItems> items = [];
    priceItemsResponse.value?.brands?.forEach((element) {
      if (element.id == selectedBrand.value) {
        element.carModels?.forEach((element) {
          if (element.brandId == selectedBrand.value) {
            element.carTypes?.forEach((element) {
              if (element.id == selectedCarType.value) {
                items = element.priceItems ?? [];
              }
            });
          }
        });
      }
    });
    print( priceItemsResponse.value?.toJson());
    priceItems.value = items;
  }

  void updateColors(String? str) {
    if (str == null) return;

    selectedColors.value = str;
    turn.value = 5;

    colorsCars.value.forEach((key, value) {
      if (value == str) {
        colorId.value = key;
      }
    });
  }

  void updateFromYear(String? str) {
    if (str == null) return;

    selectedFromYear.value = str;
    turn.value = 6;

    carTypeManufactureYears.value.forEach((key, value) {
      if (value == str) {
        fromYearId.value = key;
      }
    });
  }

  void updateGuarantee(String? str) {
    if (str == null) return;

    selectedGaurantee.value = str;
    turn.value = 7;
  }

  void updateMileage(String str) {
    millageController.text = str.usePersianNumbers();
    int value = (double.tryParse(str.toEnglishDigit()) ?? 0).toInt();
    if (value > 100000) {
      kilometerValues.value = SfRangeValues(0, 100000);
    } else {
      kilometerValues.value = SfRangeValues(0, value);
    }
  }

  void updateKilometerValues(SfRangeValues values) {
    kilometerValues.value = SfRangeValues(0, values.end);
    millageController.text = (kilometerValues.value.end).toInt().toString().usePersianNumbers();
  }
// Add these methods to your PricePageController class

// Method to check if car is damaged (has selections)
  bool get isCarDamaged => selectedIdsMap.value.isNotEmpty;

// Method to check if car is healthy (no selections)
  bool get isCarHealthy => selectedIdsMap.value.isEmpty;

// Enhanced reset method with toast
  void resetCarStatus() {
    selectedIdsMap.value = {};
    carStatusDescription.value = {};
    showToast(ToastState.SUCCESS, 'وضعیت خودرو سالم در نظر گرفته می‌شود');
  }

// Enhanced clear method without toast
  void clearAllSelections() {
    selectedIdsMap.value = {};
    carStatusDescription.value = {};
  }

// Method to set car as damaged (called when damage checkbox is selected)
  void setCarAsDamaged() {
    // If no items are selected yet, we might want to show a message or guide user
    if (selectedIdsMap.value.isEmpty) {
      showToast(ToastState.INFO, 'لطفاً قسمت‌های آسیب‌دیده خودرو را مشخص کنید');
    }
  }

// Enhanced item selection method with proper reactive updates
  void updateItemSelection(String elementId, String valueId, String elementDesc, String valueDesc) {
    // Create new maps to trigger reactivity
    Map<String, String> updatedMap = Map.from(selectedIdsMap.value);
    Map<String, String> updatedDescMap = Map.from(carStatusDescription.value);

    updatedMap[elementId] = valueId;
    updatedDescMap[elementDesc] = valueDesc;

    selectedIdsMap.value = updatedMap;
    carStatusDescription.value = updatedDescMap;
  }

// Method to remove specific item selection
  void removeItemSelection(String elementId, String elementDesc) {
    Map<String, String> updatedMap = Map.from(selectedIdsMap.value);
    Map<String, String> updatedDescMap = Map.from(carStatusDescription.value);

    updatedMap.remove(elementId);
    updatedDescMap.remove(elementDesc);

    selectedIdsMap.value = updatedMap;
    carStatusDescription.value = updatedDescMap;
  }

// Method to get damage summary for display
  String getDamageSummary() {
    if (selectedIdsMap.value.isEmpty) {
      return 'سالم';
    } else {
      int damageCount = selectedIdsMap.value.length;
      return '$damageCount قسمت آسیب‌دیده';
    }
  }

// Method to validate if damage selection is complete
  bool isDamageSelectionValid() {
    // Add your validation logic here
    // For example, check if at least one damage is selected when car is marked as damaged
    return true;
  }
  void switchToCarState() {
    if (selectedFromYear.value != null &&
        selectedBrand.value != null &&
        selectedCarModel.value != null &&
        selectedColors.value != null &&
        millageController.text.isNotEmpty) {
      state.value = PageState.CarState;
    } else {
      showToast(ToastState.ERROR,
          'لطفا مقادیر خواسته شده را تکمیل و\n سپس نقاط آسیب دیده را مشخص نمایید');
    }
  }

  void switchToFormState() {
    state.value = PageState.Form;
  }



  Future<bool> calculatePrice() async {
    if (selectedFromYear.value != null &&
        selectedBrand.value != null &&
        selectedCarModel.value != null &&
        selectedColors.value != null &&
        millageController.text.isNotEmpty) {

      List<String> itemValueIds = [];
      selectedIdsMap.value.forEach((key, value) {
        itemValueIds.add(value);
      });

      int mileage = double.tryParse(millageController.text.toEnglishDigit().trim())?.toInt() ?? 0;

      var response = await DioClient.instance.estimatePrice(
          carTypeId: selectedCarType.value??"",
          colorId: selectedColors.value??"",
          yearId: selectedFromYear.value??"",
          mileage: mileage.toString(),
          itemValueIds: itemValueIds
      );

      if (response?.status == 0) {
        price.value = response?.price ?? "";
        lowestPrice.value = response?.minPrice ?? "";
        highestPrice.value = response?.maxPrice ?? "";
        return true;
      } else {
        showToast(ToastState.ERROR, 'خطا در دریافت اطلاعات');
        return false;
      }
    } else {
      showToast(ToastState.ERROR, 'لطفا تمامی مقادیر را تکمیل نمایید');
      return false;
    }
  }
}