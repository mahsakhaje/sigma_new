import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/storage_helper.dart';
import 'package:sigma/models/user_info_model.dart';

enum Gender { male, female }

class EditProfileController extends GetxController {
  final RxString phoneNumber = ''.obs;
  final RxString supportNumber = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  var userGender = Gender.male.obs;

  final RxBool isEnabled = false.obs;
  final RxBool isLoading = false.obs;
  final RxMap<String, String> geoNames = <String, String>{}.obs;
  final RxMap<String, String> geoCityNames = <String, String>{}.obs;

  final RxnString provinceId = RxnString();
  final RxnString cityId = RxnString();
  final RxnString selectedProvince = RxnString();
  final RxnString selectedCity = RxnString();
  final RxString fullName = ''.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void setUserGender(Gender gender) {
    if (isEnabled.value) userGender.value = gender;
  }

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    isLoading.value = true;

    try {
      phoneNumber.value = await StorageHelper().getPhoneNumber() ?? '';
      final userInfo = await DioClient.instance.getUserInfo();

      await _loadProvinces();
      if (userInfo != null && userInfo.message == 'OK') {
        await _populateUserData(userInfo);
      }

      final supportResponse = await DioClient.instance.getSupportTelephone();
      supportNumber.value = supportResponse?.text ?? '';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _populateUserData(UserInfoResponse userInfo) async {
    nameController.text = userInfo.account?.name ?? '';
    lastNameController.text = userInfo.account?.lastName ?? '';
    nationalIdController.text =
        (userInfo.account?.nationalId ?? '').usePersianNumbers();
    addressController.text =
        (userInfo.account?.accountAddress ?? '').usePersianNumbers();
    postalCodeController.text =
        (userInfo.account?.postalCode ?? '').usePersianNumbers();
    userGender.value =
        userInfo.account?.sex == 'F' ? Gender.female : Gender.male;
    fullName.value =
        '${userInfo.account?.name ?? ''} ${userInfo.account?.lastName ?? ''}';

    provinceId.value = userInfo.account?.provinceId ?? '';
    cityId.value = userInfo.account?.geoNameId ?? '';
    selectedCity.value = userInfo.account?.geoNameDescription ?? '';
    selectedProvince.value = userInfo.account?.provinceDescription ?? '';
    provinceController.text = selectedProvince.value ?? "";
    cityController.text = selectedCity.value ?? '';
    print(geoNames);
    geoNames.forEach((key, value) {
      if (value == selectedProvince.value) {
        selectedProvince.value = key;
        return;
      }
    });
    provinceId.value = selectedProvince.value ?? '';
    geoCityNames.clear();
    await _loadCities();
    geoCityNames.forEach((key, value) {
      if (value == selectedCity.value) {
        selectedCity.value = key;
        return;
      }
    });
  }

  Future<void> _loadProvinces() async {
    final response = await DioClient.instance.getProvinces();
    if (response != null && response.message == 'OK') {
      geoNames.clear();
      response.geoNames?.forEach((element) {
        if (element.id != null && element.description != null) {
          geoNames[element.id!] = element.description!;
        }
      });
      print(geoNames);
    }
  }

  Future<void> _loadCities() async {
    if (provinceId?.value?.isEmpty ?? true) return;

    final response = await DioClient.instance.getCities(provinceId.value ?? "");
    if (response?.message == 'OK') {
      geoCityNames.clear();
      response?.geoNames?.forEach((element) {
        if (element.id != null && element.description != null) {
          geoCityNames[element.id!] = element.description!;
        }
      });
    }
  }

  Future<void> onProvinceChanged(String? province) async {
    print('called');
    if (!isEnabled.value) return;
    print(province);
    selectedProvince.value = province ?? '';
    provinceId.value = selectedProvince.value;
    await _loadCities();
    selectedCity.value = null;
  }

  void onCityChanged(String? city) {
    print('called2');
    if (!isEnabled.value) return;

    selectedCity.value = city ?? '';
    cityId.value = selectedCity.value;
  }

  Future<void> submitForm() async {
    if (selectedCity.value.isNull || selectedProvince.value.isNull) {
      showToast(ToastState.ERROR, 'لطفا استان و شهر خودرا انتخاب نمایید');
      return;
    }
    if (!isEnabled.value) {
      isEnabled.value = true;
      return;
    }

    if ((formKey.currentState?.validate() ?? false) &&
        (postalCodeController.text.isEmpty ||
            postalCodeController.text.length == 10)) {
      isLoading.value = true;

      try {
        final response = await DioClient.instance.updateUserInfo(
          nationalId: nationalIdController.text.toEnglishDigit(),
          cellNumber: phoneNumber.value.toEnglishDigit(),
          name: nameController.text.toEnglishDigit(),
          address: addressController.text.toEnglishDigit(),
          geoNameId: cityId.value,
          gender: userGender.value == Gender.male ? 'M' : 'F',
          postalCode: postalCodeController.text.toEnglishDigit(),
          lastName: lastNameController.text.toEnglishDigit(),
          isReal: true,
        );

        if (response?.message == "OK") {
          showToast(ToastState.SUCCESS, 'تغییرات با موفقیت ذخیره شد');
          fullName.value = '${nameController.text} ${lastNameController.text}';
          cityController.text = geoCityNames[selectedCity] ?? "";
          provinceController.text = geoNames[selectedProvince] ?? "";
          isEnabled.value = false;
        }
      } finally {
        isLoading.value = false;
      }
    } else if (postalCodeController.text.isNotEmpty &&
        postalCodeController.text.length != 10) {
      showToast(ToastState.ERROR, 'کدپستی وارد شده صحیح نیست');
    }
  }
}
