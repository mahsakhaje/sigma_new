import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/models/all_cars_json_model.dart';
import 'package:sigma/models/banners_response.dart';
import 'package:sigma/models/color_response_model.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';
import 'package:sigma/models/trim_color_response.dart';
import 'package:sigma/pages/buy_menu/buy_menu_page.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../compare_cars/compare_cars_controller.dart';

enum AdvertisePageState { filter, list }

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

enum MultiSelectListType { Brand, Model, Type, Color, City, None }

class AdvertiseController extends GetxController {
  AdvertiseController(dynamic state) {
    print('4');
    print(state =='NEW');
    if (state =='NEW') {
      orderState = 'NEW';
    }
    if (state == 'USED') {
      orderState = 'USED';
    } else {
      orderState = '';
    }
    print('3');
    print(orderState);
  }

  final RxList<SalesOrders> orders = <SalesOrders>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool filterLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxBool showFilterModal = false.obs;
  final RxString compareCarId = ''.obs;
  final RxBool isCompareMode = false.obs;
  String orderState = '';
  final Rx<AdvertisePageState> pageState = AdvertisePageState.list.obs;
  final TextEditingController searchController = TextEditingController();

  final RxString selectedCity = ''.obs;
  final RxString cityId = ''.obs;
  final RxInt pl = 5.obs;
  final RxInt pn = 0.obs;
  final RxInt total = 0.obs;

  final RxList<bool> isExpandedList = List.generate(8, (index) => false).obs;

  final Rx<AllCarsJsonModel?> allCarsJsonModel = Rx<AllCarsJsonModel?>(null);
  final Rx<TrimColorResponse?> trimColorResponse = Rx<TrimColorResponse?>(null);
  final Rx<ColorResponse?> colorResponse = Rx<ColorResponse?>(null);

  final RxBool disabledFilter = true.obs;

  final RxList<TimeValue> brands = <TimeValue>[].obs;
  final RxList<TimeValue> cities = <TimeValue>[].obs;
  final RxList<int> selectedBrands = <int>[].obs;
  final RxList<int> selectedTypes = <int>[].obs;
  final RxList<int> selectedModels = <int>[].obs;
  final RxList<int> selectedCarColors = <int>[].obs;
  final RxList<int> selectedCities = <int>[].obs;
  final RxList<TimeValue> carModels = <TimeValue>[].obs;
  final RxList<TimeValue> carTypes = <TimeValue>[].obs;
  final RxList<TimeValue> colorsCars = <TimeValue>[].obs;
  final scrollController = ScrollController();

  final RxBool isBrandSelected = false.obs;
  final RxString brandId = ''.obs;
  final RxString modelId = ''.obs;
  final RxString typeId = ''.obs;
  final currentPage = 0.obs;
  final banners = <Banners>[].obs;
  Timer? _timer;
  late PageController pageController;
  final Rx<SfRangeValues> priceValues = SfRangeValues(200.0, 9000.0).obs;
  final Rx<SfRangeValues> yearValues = SfRangeValues(1380, 1404).obs;

  final RxList<TimeValue> fromYears = <TimeValue>[
    TimeValue(1380, '1380'),
    TimeValue(1381, '1381'),
    TimeValue(1382, '1382'),
    TimeValue(1383, '1383'),
    TimeValue(1384, '1384'),
    TimeValue(1385, '1385'),
    TimeValue(1386, '1386'),
    TimeValue(1387, '1387'),
    TimeValue(1388, '1388'),
    TimeValue(1389, '1389'),
    TimeValue(1390, '1390'),
    TimeValue(1391, '1391'),
    TimeValue(1392, '1392'),
    TimeValue(1393, '1393'),
    TimeValue(1394, '1394'),
    TimeValue(1395, '1395'),
    TimeValue(1396, '1396'),
    TimeValue(1397, '1397'),
    TimeValue(1398, '1398'),
    TimeValue(1399, '1399'),
    TimeValue(1400, '1400'),
    TimeValue(1401, '1401'),
    TimeValue(1402, '1402'),
    TimeValue(1403, '1403'),
    TimeValue(1404, '1404'),
  ].obs;
  var isFetchingMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('1');
    print(orderState);
    final arguments = Get.arguments;

    if (arguments != null && arguments is Map<String, dynamic>) {
      isCompareMode.value = true;
      if (arguments.containsKey('compareCarId')) {
        compareCarId.value = arguments['compareCarId'];

        isCompareMode.value = true;
      }
    }
    scrollController.addListener(() {
      print((scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent)
              .toString() +
          '**************************************');
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore.value &&
          !isFetchingMore.value) {
        getOrders();
        print('called end of list');
      }
    });
    loadInitialData();
  }

  void handleCarItemTap(String carId) {
    if (isCompareMode.value) {
      Get.toNamed(RouteName.compare,
          arguments: Compare(
            compareCarId.value,
            carId,
          ));
    } else {
      Get.toNamed(RouteName.carDetails, arguments: {'id': carId});
    }
  }

  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;
      await Future.wait([
        fetchAllCarsJson(),
        fetchCities(),
      ]);
      await getOrders();
      // if (!kIsWeb) {
      //   await FirebaseAnalytics.instance.logEvent(name: advertise_key);
      // }
      pageController = PageController(initialPage: 0);
      fetchBanners();
    } catch (e) {
    } finally {
      isLoading.value = false;
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
      brands.add(
          TimeValue(int.parse(element.id ?? '0'), element.description ?? ''));
    });
  }

  Future<void> fetchCities() async {
    var response = await DioClient.instance.getShowroomCities();
    if (response != null && response.message == 'OK') {
      cities.clear();
      response.geoNames?.forEach((element) {
        if (element.id != null && element.description != null) {
          cities.add(TimeValue(
              int.parse(element.id ?? '0'), element.description ?? ''));
        }
      });
    }
  }

  Future<void> getOrders({
    String? brandId,
    String? carModelId,
    String? carTypeIds,
    String? carTypeId,
    String? colorId,
    String? fromAmount,
    String? toAmount,
    String? cityIds,
    String? cityId,
    String? fromYear,
    String? toYear,
  }) async {
    try {
      if (isFetchingMore.value) return;
      isFetchingMore.value = true;
      isLoading.value = true;
      pn.value++;
      print('2');
      print(orderState);
      var response = await DioClient.instance.getSalesOrdersWithFilter(
        brandId: brandId,
        carModelId: carModelId,
        carTypeIds: carTypeIds,
        carTypeId: carTypeId,
        colorId: colorId,
        fromAmount: fromAmount ?? '',
        toAmount: toAmount ?? '',
        cityIds: cityIds,
        cityId: cityId,
        state: orderState,
        fromYear: fromYear ?? '',
        toYear: toYear ?? '',
        pl: pl.value,
        pn: pn.value,
      );

      if (response?.message == 'OK') {
        if (pn.value == 0) {
          orders.clear();
        }

        if (response?.salesOrders != null) {
          orders.addAll(response!.salesOrders!);
        }
        total.value = int.tryParse(response?.count ?? '0') ?? 0;

        hasMore.value = (orders.length) != total.value;
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
      filterLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  void toggleBrand(TimeValue value, bool checked) {
    if (checked) {
      selectedBrands.add(value.id);
    } else {
      selectedBrands.remove(value.id);
    }

    // Reset dependent selections
    carModels.clear();
    colorsCars.clear();

    // Load car models based on selected brands
    selectedBrands.forEach((brandId) {
      this.brandId.value = brandId.toString();
      allCarsJsonModel.value?.brands?.forEach((brand) {
        if (brand.id == this.brandId.value) {
          brand.carModels?.forEach((model) {
            carModels.add(TimeValue(int.parse(model.id!), model.description!));
          });
        }
      });
    });

    disabledFilter.value = false;
  }

  void toggleModel(TimeValue value, bool checked) {
    if (checked) {
      selectedModels.add(value.id);
    } else {
      selectedModels.remove(value.id);
    }

    // Reset dependent selections
    colorsCars.clear();

    // Clear car types and re-load based on selection
    carTypes.clear();

    selectedModels.forEach((modelId) {
      this.modelId.value = modelId.toString();
      allCarsJsonModel.value?.brands?.forEach((brand) {
        brand.carModels?.forEach((model) {
          if (model.id == this.modelId.value) {
            model.carTypes?.forEach((type) {
              final typeValue =
                  TimeValue(int.parse(type.id!), type.description!);

              // Only add unique types
              if (!carTypes.any((element) => element.id == typeValue.id)) {
                carTypes.add(typeValue);
              }
            });
          }
        });
      });
    });

    disabledFilter.value = false;
  }

  void toggleType(TimeValue value, bool checked) {
    if (checked) {
      selectedTypes.add(value.id);
    } else {
      selectedTypes.remove(value.id);
    }

    // Reset and reload colors
    colorsCars.clear();

    selectedTypes.forEach((typeId) {
      allCarsJsonModel.value?.brands?.forEach((brand) {
        brand.carModels?.forEach((model) {
          model.carTypes?.forEach((type) {
            if (selectedTypes.contains(int.tryParse(type.id ?? '0'))) {
              type.carTypeColors?.forEach((color) {
                colorsCars.add(TimeValue(
                    int.tryParse(color.id ?? '0') ?? 0, color.color ?? ""));
              });
            }
          });
        });
      });
    });

    // Remove duplicates
    final uniqueColors = <TimeValue>[];
    final ids = <int>{};

    for (var color in colorsCars) {
      if (ids.add(color.id)) {
        uniqueColors.add(color);
      }
    }

    colorsCars.clear();
    colorsCars.addAll(uniqueColors);

    disabledFilter.value = false;
  }

  void toggleColor(TimeValue value, bool checked) {
    if (checked) {
      selectedCarColors.add(value.id);
    } else {
      selectedCarColors.remove(value.id);
    }
    disabledFilter.value = false;
  }

  void toggleCity(TimeValue value, bool checked) {
    if (checked) {
      selectedCities.add(value.id);
    } else {
      selectedCities.remove(value.id);
    }
    disabledFilter.value = false;
  }

  void updatePriceValues(SfRangeValues values) {
    priceValues.value = values;
    disabledFilter.value = false;
  }

  void updateYearValues(SfRangeValues values) {
    yearValues.value = values;
    disabledFilter.value = false;
  }

  bool getValue(MultiSelectListType listType, TimeValue value) {
    switch (listType) {
      case MultiSelectListType.Brand:
        return selectedBrands.contains(value.id);
      case MultiSelectListType.City:
        return selectedCities.contains(value.id);
      case MultiSelectListType.Model:
        return selectedModels.contains(value.id);
      case MultiSelectListType.Type:
        return selectedTypes.contains(value.id);
      case MultiSelectListType.Color:
        return selectedCarColors.contains(value.id);
      default:
        return false;
    }
  }

  String getSubtitleOfSections(MultiSelectListType type) {
    switch (type) {
      case MultiSelectListType.Brand:
        List<String> values = [];
        brands.forEach((element) {
          if (selectedBrands.contains(element.id)) {
            values.add(element.value);
          }
        });
        return values.toString();
      case MultiSelectListType.City:
        List<String> values = [];
        cities.forEach((element) {
          if (selectedCities.contains(element.id)) {
            values.add(element.value);
          }
        });
        return values.toString();
      case MultiSelectListType.Model:
        List<String> values = [];
        carModels.forEach((element) {
          if (selectedModels.contains(element.id)) {
            values.add(element.value);
          }
        });
        return values.toString();
      case MultiSelectListType.Type:
        List<String> values = [];
        carTypes.forEach((element) {
          if (selectedTypes.contains(element.id)) {
            values.add(element.value);
          }
        });
        return values.toString();
      case MultiSelectListType.Color:
        List<String> values = [];
        colorsCars.forEach((element) {
          if (selectedCarColors.contains(element.id)) {
            values.add(element.value);
          }
        });
        return values.toString();
      default:
        return '';
    }
  }

  void toggleExpansionTile(int index) {
    isExpandedList[index] = !isExpandedList[index];
    update();
  }

  void togglePageState() {
    if (showFilterModal.value) {
      pageState.value = AdvertisePageState.filter;
      showFilterModal.value = false;
    } else {
      pageState.value = AdvertisePageState.list;
      showFilterModal.value = true;
    }
  }

  void closeAllExpansionTiles() {
    for (var i = 0; i < isExpandedList.length; i++) {
      isExpandedList[i] = false;
    }
    update();
  }

  Future<void> fetchBanners() async {
    try {
      var response = await DioClient.instance.getBanners();

      if (response != null && response.message == 'OK') {
        banners.value = response.banners ?? [];

        startAutoSlide();
      } else {
        banners.value = [];
      }
    } catch (e) {
      banners.value = [];
      print('Error fetching banners: $e');
    } finally {}
  }

  void startAutoSlide() {
    if (banners.isNotEmpty) {
      _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
        if (currentPage.value < banners.length - 1) {
          currentPage.value++;
        } else {
          currentPage.value = 0;
        }

        pageController.animateToPage(
          currentPage.value,
          duration: Duration(milliseconds: 2000),
          curve: Curves.linear,
        );
      });
    }
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }

  void resetFilters() {
    selectedBrands.clear();
    selectedModels.clear();
    selectedTypes.clear();
    selectedCarColors.clear();
    selectedCities.clear();
    carModels.clear();
    carTypes.clear();
    colorsCars.clear();

    brandId.value = '';
    modelId.value = '';
    typeId.value = '';
    cityId.value = '';

    priceValues.value = SfRangeValues(200.0, 9000.0);
    yearValues.value = SfRangeValues(1380, 1405);
    Get.back();
    disabledFilter.value = true;
    closeAllExpansionTiles();
    reset();
    getOrders();
  }

  void reset() {
    pn.value = 0;
    orders.clear();
    hasMore.value = true;
  }

  Future<void> applyFilters() async {
    Navigator.pop(Get.context!);
    // showFilterModal.value = false;
    // pageState.value = AdvertisePageState.list;

    if (disabledFilter.value) {
      pageState.value = AdvertisePageState.list;
      return;
    }

    filterLoading.value = true;
    reset();

    String brandIds = selectedBrands.map((id) => id.toString()).join(',');
    String modelIds = selectedModels.map((id) => id.toString()).join(',');
    String typeIds = selectedTypes.map((id) => id.toString()).join(',');
    String colorIds = selectedCarColors.map((id) => id.toString()).join(',');
    String cityIds = selectedCities.map((id) => id.toString()).join(',');

    pageState.value = AdvertisePageState.list;

    await getOrders(
      brandId: brandIds.isNotEmpty ? brandIds : '',
      carModelId: modelIds.isNotEmpty ? modelIds : "",
      carTypeIds: typeIds.isNotEmpty ? typeIds : "",
      carTypeId: typeId.value == '0' ? '' : typeId.value,
      colorId: colorIds.isNotEmpty ? colorIds : '',
      fromAmount: (priceValues.value.start * 1000000).toString(),
      toAmount: (priceValues.value.end * 1000000).toString(),
      cityIds: cityIds.length > 1 ? cityIds : '',
      cityId: cityIds.length == 1 ? cityIds : '',
      fromYear:
          fromYears.isEmpty ? "" : yearValues.value.start.toInt().toString(),
      toYear: fromYears.isEmpty ? "" : yearValues.value.end.toInt().toString(),
    );
  }

  Future<void> changeLike(String id) async {
    try {
      var response = await DioClient.instance.changeLike(id: id);
      // Find the order and toggle its favCount
      final index = orders.indexWhere((order) => order.id == id);
      if (index != -1) {
        final order = orders[index];
        order.favCount = order.favCount == '1' ? '0' : '1';
        orders[index] = order;
      }
    } catch (e) {
      print('Error changing like status: $e');
    }
  }
}
