import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/all_cars_json_model.dart';
import 'package:sigma/models/stocks_model.dart';

enum TabStatus { TOTAL, USUAL }

class TimeValue {
  final int id;
  final String value;

  TimeValue(this.id, this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeValue && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class StocksController extends GetxController {
  final RxList<Stocks> stocks = <Stocks>[].obs;
  final RxList<Stocks> totalStocks = <Stocks>[].obs;
  final RxList<Stocks> filteredStocks = <Stocks>[].obs;
  final String firstNumber = '09025382448';
  final String secondNumber = '02177196332';
  final String thirdNumber = '02177092569';

  RxBool isLoading = true.obs;
  Rx<TabStatus> tab = TabStatus.USUAL.obs;

  // دریافت داده‌های برند، مدل و تیپ از AllCarsJson
  final Rx<AllCarsJsonModel?> allCarsJsonModel = Rx<AllCarsJsonModel?>(null);

  // فیلترهای انتخاب شده (فقط یک مقدار برای هر کدام)
  final Rxn<String>? selectedBrandId = Rxn<String>();
  final Rxn<String>? selectedModelId = Rxn<String>();
  final Rxn<String>? selectedTypeId = Rxn<String>();
  final Rxn<String> selectedMileage = Rxn<String>();
  var colors = <String, String>{}.obs;
  var mileageState = {'NEW': 'صفر', 'USED': 'کارکرده'};
  var carManufactureYears = <String, String>{}.obs;
  var selectedColorId = Rx<String?>(null);
  var selectedYear = Rx<String?>(null);

  // لیست‌های برای فیلترها (مانند کنترلر آگهی‌ها)
  final brands = <String, String>{}.obs;
  final carModels = <String, String>{}.obs;
  final carTypes = <String, String>{}.obs;
  final availableYears = <String, String>{}.obs;
  final RxList<String> availableMileages = <String>[].obs;

  @override
  void onInit() {
    getData();
    fetchAllCarsJson();
    super.onInit();
  }

  toggleTab() {
    resetFilters();
    if (tab.value == TabStatus.TOTAL) {
      tab.value = TabStatus.USUAL;
    } else {
      tab.value = TabStatus.TOTAL;
    }
    if (totalStocks.isEmpty || stocks.isEmpty) {
      getStocks();
    }
    ;
  }

  Future<void> getData() async {
    try {
      final results = await Future.wait([
        getStocks(),
      ]);
      isLoading.value = false;
      print('Both API calls completed');
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
    }
  }

  Future<void> getStocks() async {
    var response = await DioClient.instance.getStocks(
        tab.value == TabStatus.TOTAL ? '1' : '',
        brandId: selectedBrandId?.value,
        carModelId: selectedModelId?.value,
        carTypeId: selectedTypeId?.value,
        mileageState: selectedMileage.value,
        colorId: selectedColorId.value,
        manufactureYearId: selectedYear.value);
    print(response);
    if (response?.message == 'OK') {
      if (tab.value == TabStatus.TOTAL) {
        totalStocks.value = response?.stocks ?? [];
      } else {
        stocks.value = response?.stocks ?? [];
      }
    }
  }

  Future<void> fetchAllCarsJson() async {
    var responseAllCar = await DioClient.instance.getAllCarsJson();
    if (responseAllCar?.message == 'OK') {
      allCarsJsonModel.value = responseAllCar;
      loadBrands();
    }
  }

  void loadBrands() {
    brands.clear();
    allCarsJsonModel.value?.brands?.forEach((element) {
      brands[element.id ?? '0'] = element.description ?? '';
    });
  }

  // اعمال فیلترهای لوکال

  // انتخاب برند
  void selectBrand(String? value) {
    selectedBrandId?.value = value;
    carModels.clear();
    selectedModelId?.value = null;
    carTypes.clear();
    selectedTypeId?.value = null;

    allCarsJsonModel.value?.brands?.forEach((brand) {
      if (brand.id == selectedBrandId?.value) {
        brand.carModels?.forEach((model) {
          carModels[model.id!] = model.description!;
        });
      }
    });
  }

  // انتخاب مدل
  void selectModel(String? value) {
    selectedModelId?.value = value;

    carTypes.clear();
    selectedTypeId?.value = null;

    allCarsJsonModel?.value?.brands?.forEach((element) {
      if (element.id == selectedBrandId?.value) {
        element.carModels?.forEach((element) {
          if (element.id == selectedModelId?.value) {
            element.carTypes?.forEach((element) {
              if (element.id != null && element.description != null) {
                carTypes[element.id!] = element.description!;
              }
            });
          }
        });
      }
    });
  }

  // انتخاب تیپ
  void selectType(String? value) {
    selectedTypeId?.value = value;

    allCarsJsonModel?.value?.brands?.forEach((element) {
      if (element.id == selectedBrandId?.value) {
        element.carModels?.forEach((element) {
          if (element.id == selectedModelId?.value) {
            element.carTypes?.forEach((element) {
              if (element.id == selectedTypeId?.value) {
                // Load colors
                element.carTypeColors?.forEach((element) {
                  if (element.colorId != null && element.color != null) {
                    colors[element.colorId!] = element.color!;
                  }
                });

                // Load manufacture years
                element.carTypeManufactureYears?.forEach((element) {
                  if (element.persianYear != null &&
                      element.miladiYear != null) {
                    carManufactureYears[element.manufactureYearId!] =
                        "${element.miladiYear}_${element.persianYear}";
                  }
                });
              }
            });
          }
        });
      }
    });
  }

  // انتخاب سال
  void selectYear(String? value) {
    selectedYear.value = value;
    print(selectedYear);
  }

  void selectColor(String? value) {
    selectedColorId.value = value;
    print(selectedColorId);
  }

  // انتخاب کارکرد
  void selectMileage(String? value) {
    selectedMileage.value = value;
  }

  // ریست تمام فیلترها
  void resetFilters() {
    selectedBrandId?.value = null;
    selectedModelId?.value = null;
    selectedTypeId?.value = null;
    selectedYear.value = null;
    selectedMileage.value = null;
    selectedColorId.value = null;
    getStocks();
  }

  // بررسی وجود فیلتر فعال
  bool get hasActiveFilters {
    return selectedBrandId?.value != null ||
        selectedModelId?.value != null ||
        selectedTypeId?.value != null ||
        selectedYear.value != null ||
        selectedMileage.value != null;
  }

  // تعداد فیلترهای فعال
  int get activeFiltersCount {
    int count = 0;
    if (selectedBrandId?.value != null) count++;
    if (selectedModelId?.value != null) count++;
    if (selectedTypeId?.value != null) count++;
    if (selectedYear.value != null) count++;
    if (selectedMileage.value != null) count++;
    return count;
  }
}
