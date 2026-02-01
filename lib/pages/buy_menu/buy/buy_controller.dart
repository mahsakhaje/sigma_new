import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/models/all_cars_json_model.dart';
import 'package:sigma/helper/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var isFirstLoading = true.obs;
  var turn = 0.obs;

  // Form data
  var brands = <String, String>{}.obs;
  var carModels = <String, String>{}.obs;
  var carTypes = <String, String>{}.obs;
  var colorsCars = <String, String>{}.obs;
  var trimColors = <String, String>{}.obs;
  var carTypeManufactureYearsFrom = <String, String>{}.obs;
  var carTypeManufactureYearsTo = <String, String>{}.obs;
  var cities = <String, String>{}.obs;

  // Selected values
  var selectedCity = Rx<String?>(null);
  var selectedBrand = Rx<String?>(null);
  var selectedCarModel = Rx<String?>(null);
  var selectedCarType = Rx<String?>(null);
  var selectedFromYear = Rx<String?>(null);
  var selectedToYear = Rx<String?>(null);
  var selectedKiloMeterFrom = Rx<String?>(null);
  var selectedKiloMeteTo = Rx<String?>(null);
  var selectedColors = Rx<String?>(null);
  var selectedTrimColors = Rx<String?>(null);

  // IDs for API
  var cityId = '';
  var brandId = '';
  var modelId = '';
  var typeId = '';
  var fromYearId = '';
  var toYearId = '';
  var colorId = '';
  var trimColorId = '';
  var kilometerFromId = '';
  var kiloMeterToId = '';

  // Checkbox states
  var showSimilar = false.obs;
  var wantsLoan = false.obs;
  var isSwap = false.obs;

  // Controllers
  final amountController = TextEditingController();
  final swapCommentController = TextEditingController();

  // Kilometer lists
  final kilometerFrom = ['0', '10000', '30000', '50000', '70000', '100000'].obs;
  final kilometerTo = ['0', '10000', '30000', '50000', '70000', '100000'].obs;

  // Model data
  AllCarsJsonModel? allCarsJsonModel;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  @override
  void onClose() {
    amountController.dispose();
    swapCommentController.dispose();
    super.onClose();
  }

  Future<void> _loadInitialData() async {
    try {
      // Load cities
      var citiesResponse = await DioClient.instance.getShowroomCities();
      if (citiesResponse != null && citiesResponse.message == 'OK') {
        citiesResponse.geoNames?.forEach((element) {
          if (element.id != null && element.description != null) {
            cities[element.id!] = element.description!;
          }
        });
      }

      // Load all cars data
      var responseAllCar = await DioClient.instance.getAllCarsJson();
      if (responseAllCar?.message == 'OK') {
        allCarsJsonModel = responseAllCar;

        // Load brands
        allCarsJsonModel?.brands?.forEach((element) {
          if (element.id != null && element.description != null) {
            brands[element.id!] = element.description!;
          }
        });
      }

      // Log event
      // if (!kIsWeb) {
      //   await FirebaseAnalytics.instance.logEvent(name: buy_key);
      // }
    } catch (e) {
      print('Error loading initial data: $e');
    } finally {
      isFirstLoading.value = false;
    }
  }

  void onCitySelected(String? str) {
    if (str == null) return;

    selectedCity.value = str;
    cities.forEach((key, value) {
      if (value == selectedCity.value) {
        cityId = key;
      }
    });
    turn.value = 2;
  }

  void onBrandSelected(String? str) {
    if (str == null) return;

    selectedBrand.value = str;
    brands.forEach((key, value) {
      if (value == str) {
        brandId = key;
      }
    });
    carModels.clear();
    carTypes.clear();
    selectedCarModel.value = null;
    selectedCarType.value = null;
    selectedKiloMeteTo.value = null;
    selectedFromYear.value = null;
    selectedKiloMeterFrom.value = null;
    selectedKiloMeterFrom.value = null;
    selectedToYear.value = null;
    selectedCity.value = null;
    selectedColors.value=null;
    selectedTrimColors.value=null;
    amountController.text = '';
    //clearFields();
    turn.value = 1;

    // Load car models for selected brand
    allCarsJsonModel?.brands?.forEach((element) {
      if (element.id == str) {
        element.carModels?.forEach((element) {
          if (element.id != null && element.description != null) {
            carModels[element.id!] = element.description!;
          }
        });
      }
    });
  }

  void onCarModelSelected(String? str) {
    carTypes.clear();
    selectedCarType.value = null;
    selectedKiloMeteTo.value = null;
    selectedFromYear.value = null;
    selectedKiloMeterFrom.value = null;
    selectedToYear.value = null;
    amountController.text = '';
    if (str == null) return;

    selectedCarModel.value = str;
    carModels.forEach((key, value) {
      if (value == str) {
        modelId = key;
      }
    });

    // Reset related fields
    colorsCars.clear();
    trimColors.clear();
    selectedTrimColors.value = null;
    selectedColors.value = null;
    carTypes.clear();
    selectedFromYear.value = null;
    selectedToYear.value = null;
    amountController.clear();
    carTypeManufactureYearsFrom.clear();
    carTypeManufactureYearsTo.clear();

    // Load car types for selected model
    allCarsJsonModel?.brands?.forEach((element) {
      if (element.id == selectedBrand.value) {
        element.carModels?.forEach((element) {
          if (element.id == selectedCarModel.value) {
            element.carTypes?.forEach((element) {
              if (element.id != null && element.description != null) {
                carTypes[element.id!] = element.description!;
              }
            });
          }
        });
      }
    });

    selectedCarType.value = null;
    turn.value = 3;
  }

  void onCarTypeSelected(String? str) {
    if (str == null) return;
    selectedKiloMeteTo.value = null;
    selectedFromYear.value = null;
    selectedKiloMeterFrom.value = null;
    selectedToYear.value = null;
    amountController.text = '';
    selectedCarType.value = str;
    carTypeManufactureYearsFrom.clear();
    carTypeManufactureYearsTo.clear();
    selectedFromYear.value = null;
    selectedToYear.value = null;
    amountController.clear();

    carTypes.forEach((key, value) {
      if (value == str) {
        typeId = key;
      }
    });

    // Load colors and years for selected car type
    allCarsJsonModel?.brands?.forEach((element) {
      if (element.id == selectedBrand.value) {
        element.carModels?.forEach((element) {
          if (element.id == selectedCarModel.value) {
            element.carTypes?.forEach((element) {
              if (element.id == selectedCarType.value) {
                // Load colors
                element.carTypeColors?.forEach((element) {
                  if (element.colorId != null && element.color != null) {
                    colorsCars[element.colorId!] = element.color!;
                  }
                });

                // Load trim colors
                element.carTypeTrimColors?.forEach((element) {
                  if (element.colorId != null && element.color != null) {
                    trimColors[element.colorId!] = element.color!;
                  }
                });

                // Load manufacture years
                element.carTypeManufactureYears?.forEach((element) {
                  if (element.persianYear != null &&
                      element.miladiYear != null) {
                    carTypeManufactureYearsFrom[element.persianYear!] =
                        "${element.miladiYear}_${element.persianYear}";
                  }
                });
              }
            });
          }
        });
      }
    });

    selectedTrimColors.value = null;
    selectedColors.value = null;
    turn.value = 4;
  }

  void onFromYearSelected(String? str) {
    if (str == null) return carTypeManufactureYearsTo.clear();
    carTypeManufactureYearsTo.clear();
    selectedToYear.value = null;
    carTypeManufactureYearsFrom.forEach((key, value) {
      if (value == str) {
        fromYearId = key;
      }
    });
    selectedFromYear.value = str;

    // Use 'str' directly instead of selectedFromYear.value
    int selectedYear = int.tryParse((str).substring(0, 4)) ?? 0;

    carTypeManufactureYearsFrom.forEach((key, value) {
      int currentYear = int.tryParse(key?.substring(0, 4) ?? "0000") ?? 0;
      print(currentYear);

      if (currentYear >= selectedYear) {
        carTypeManufactureYearsTo[key] = value;
      }
    });
    // Set the reactive value after processing
    turn.value = 5;
  }

  void onToYearSelected(String? str) {
    if (str == null) return;

    selectedToYear.value = str;
    selectedKiloMeteTo.value = null;
    selectedKiloMeterFrom.value = null;

    turn.value = 6;
  }

  void onKilometerFromSelected(String? str) {
    if (str == null) return;

    selectedKiloMeterFrom.value = str;
    var tempKilometerTo = <String>[];

    kilometerFrom.forEach((element) {
      int selectedKm = int.tryParse(selectedKiloMeterFrom.value ?? '0') ?? 0;
      int currentKm = int.tryParse(element) ?? 0;
      if (currentKm >= selectedKm) {
        tempKilometerTo.add(element);
      }
    });
    selectedKiloMeteTo.value = null;
    kilometerTo.value = tempKilometerTo;
    kilometerFromId = selectedKiloMeterFrom.value ?? '0';
    turn.value = 7;
  }

  void onKilometerToSelected(String? str) {
    if (str == null) return;

    selectedKiloMeteTo.value = str;
    kiloMeterToId = selectedKiloMeteTo.value ?? '100000';
    turn.value = 8;
  }

  void onColorSelected(String? str) {
    if (str == null) return;

    selectedColors.value = str;
    colorsCars.forEach((key, value) {
      if (value == selectedColors.value) {
        colorId = key;
      }
    });

    turn.value = 9;
  }

  void onTrimColorSelected(String? str) {
    if (str == null) return;

    selectedTrimColors.value = str;
    trimColors.forEach((key, value) {
      if (value == selectedTrimColors.value) {
        trimColorId = key;
      }
    });

    turn.value = 10;
  }

  void onBudgetChanged() {
    turn.value = 11;
  }

  void toggleShowSimilar(bool? value) {
    if (value != null) {
      showSimilar.value = value;
    }
  }

  void toggleWantsLoan(bool? value) {
    if (value != null) {
      wantsLoan.value = value;
    }
  }

  void toggleIsSwap(bool? value) {
    if (value != null) {
      isSwap.value = value;
    }
  }

  bool isFormValid() {
    return (selectedKiloMeterFrom.value?.isNotEmpty ?? false) &&
        (selectedKiloMeteTo.value?.isNotEmpty ?? false) &&
        (selectedBrand.value?.isNotEmpty ?? false) &&
        (selectedToYear.value?.isNotEmpty ?? false) &&
        (selectedFromYear.value?.isNotEmpty ?? false) &&
        (amountController.text.isNotEmpty);
  }

  Future<void> submitForm(
      BuildContext context, GlobalKey<FormState> formKey) async {
    hideKeyboard(context);

    // Validate form
    if (!_validateForm(formKey)) {
      showToast(ToastState.INFO,
          'لطفا تمامی موارد را مقداردهی کنید و مجددا درخواست\n  خود را ثبت نمایید');
      return;
    }

    try {
      isLoading.value = true;

      // Log event

      // Submit form data to API
      var response = await DioClient.instance.insertPurchaseOrder(
          brandId: selectedBrand.value ?? '',
          cityId: selectedCity.value ?? "",
          isSwap: isSwap.value ? '1' : '0',
          wantsLoan: wantsLoan.value ? '1' : '0',
          commentSwap: swapCommentController.text,
          budget: englishToPersian(amountController.text.replaceAll(',', ''))
              .replaceAll('٬', ''),
          carModelId: selectedCarModel.value ?? '',
          carTypeId: selectedCarType.value ?? '',
          colorId: selectedColors.value ?? "",
          similarItems: showSimilar.value ? '1' : '0',
          fromManufactureYear: selectedFromYear.value ?? "",
          fromMileage: selectedKiloMeterFrom.value ?? '',
          toManufactureYear: selectedToYear.value ?? '',
          toMileage: selectedKiloMeteTo.value ?? '',
          trimColorId: selectedTrimColors.value ?? '');

      // Reset form
      selectedBrand.value = null;
      selectedCity.value = null;
      //clearFields();

      // Show success dialog
      if (response?.message == 'OK') {
        carModels.clear();
        carTypes.clear();
        selectedCarModel.value = null;
        selectedCarType.value = null;
        selectedKiloMeteTo.value = null;
        selectedFromYear.value = null;
        selectedKiloMeterFrom.value = null;
        selectedKiloMeterFrom.value = null;
        selectedToYear.value = null;
        selectedCity.value = null;
        amountController.text = '';
        _showSuccessDialog(context, response);
      }
    } catch (e) {
      print('Error submitting form: $e');
      showToast(ToastState.ERROR, 'خطا در ثبت درخواست');
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm(GlobalKey<FormState> formKey) {
    return (selectedCity.value?.isNotEmpty ?? false) &&
        (selectedKiloMeterFrom.value?.isNotEmpty ?? false) &&
        (selectedKiloMeteTo.value?.isNotEmpty ?? false) &&
        (selectedBrand.value?.isNotEmpty ?? false) &&
        (selectedToYear.value?.isNotEmpty ?? false) &&
        (selectedFromYear.value?.isNotEmpty ?? false) &&
        formKey.currentState!.validate() &&
        (amountController.text.isNotEmpty);
  }

  void _showSuccessDialog(BuildContext context, dynamic response) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                      'درخواست شما با موفقیت ثبت شد، کارشناسان ما در اسرع وقت با شما تماس می‌گیرند.'
                          .usePersianNumbers(),
                      textAlign: TextAlign.center,
                      isRtl: true,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: 12),
                  _buildOrderNumberBox(response),
                  SizedBox(height: 16),
                  _buildActionButtons(context),

                ],
              ),
            ));
  }

  void _showPelakSefidDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,

        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Corner radius of 8
          ),
          insetPadding: EdgeInsets.all(16),
              content: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 26,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Get.toNamed(RouteName.advertise);
                          },
                          child: Icon(
                            Icons.close_outlined,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Image.asset('assets/pelaksefid.png'),

                  SizedBox(
                    height: 36,
                  ),
                  CustomText(
                      'اگر مایل هستید آگهی های پلاک سفید را هم مشاهده نمائید.',
                      textAlign: TextAlign.center,
                      isRtl: true,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: 92),
                  ConfirmButton(
                      () => {
                            launchUrl(
                                Uri.parse('https://pelaksefid.ir/ads/all/'),
                                mode: LaunchMode.inAppWebView)
                          },
                      'پلاک سفید')
                ],
              ),
            ));
  }

  Widget _buildOrderNumberBox(dynamic response) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (!kIsWeb)
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: response?.purchaseOrder?.orderNumber ?? ''));
                      showToast(ToastState.SUCCESS, 'کدرهگیری کپی شد');
                    },
                    child: Icon(
                      Icons.copy,
                      color: Colors.black87,
                    ),
                  ),
                SizedBox(width: 8),
                CustomText(response?.purchaseOrder?.orderNumber ?? '',
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ],
            ),
            CustomText('کد رهگیری:',
                isRtl: true, fontWeight: FontWeight.bold, color: Colors.black87)
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: ConfirmButton(
          () async {
            Navigator.of(context).pop();
            _showPelakSefidDialog(context);
          },
          'مشاهده آگهی ها',
          borderRadius: 8,
          fontSize: 12,
        ),
      )
    ]);
  }
}
