import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/storage_helper.dart';

class AuthController extends GetxController {
  var currentPage = AuthPageState.welcome.obs;
  var isLoading = false.obs;
  var hasConfirmedRules = false.obs;
  var registerState = RegisterPageState.forms.obs;
  var userState = UserState.normal.obs;
  var userGender = Gender.male.obs;
  var otpState = OtpState.form.obs;
  final GlobalKey<FormState> haghighiFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> legalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final nationalCodeController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final forgetMobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();
  final referralCodeController = TextEditingController();
  final emailController = TextEditingController();
  final loginMobileNumberController = TextEditingController();

  final haNameController = TextEditingController();
  final haLastNameController = TextEditingController();
  final haNationalCodeController = TextEditingController();
  final haMobileNumberController = TextEditingController();
  final haPasswordController = TextEditingController();
  final haPasswordRepeatController = TextEditingController();
  final haReferralCodeController = TextEditingController();
  final haEmailController = TextEditingController();
  final coNameController = TextEditingController();
  final coNationalCodeController = TextEditingController();
  final codeController = TextEditingController();
  final otpCodeController = TextEditingController();
  final RxMap<String, String> geoNames = <String, String>{}.obs;
  final RxMap<String, String> geoCityNames = <String, String>{}.obs;
  final RxnString selectedProvince = RxnString();
  final RxnString selectedCity = RxnString();
  final Rx<PageState> currentState = PageState.EnterPhoneNumber.obs;
  final RxString supportNumber = ''.obs;

  final RxString provinceId = ''.obs;
  final RxString cityId = ''.obs;

  void goToLogin() => currentPage.value = AuthPageState.login;

  void goToRegister() => currentPage.value = AuthPageState.register;

  void goToForget() => currentPage.value = AuthPageState.forgetPassword;

  void goToWelcome() => currentPage.value = AuthPageState.welcome;

  void setUserGender(Gender gender) => userGender.value = gender;

  void setUserState(UserState state) => userState.value = state;

  void setHasConfirmedRules(bool? state) =>
      hasConfirmedRules.value = state ?? false;

  void setRegisterState(RegisterPageState state) => registerState.value = state;

  @override
  void onInit() {
    super.onInit();
    _getSupportNumber();
    _loadProvinces();
    _loadCities();
  }

  Future<void> _getSupportNumber() async {
    try {
      var response = await DioClient.instance.getSupportTelephone();
      if (response?.text != null) {
        supportNumber.value = response!.text!;
      }
    } catch (e) {
      // Handle error silently or log it
    }
  }

  Future<void> forgetPassword() async {
    bool isValid = forgetFormKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    isLoading.value = true;

    try {
      var response = await DioClient.instance
          .forgetPassword(cellNumber: forgetMobileNumberController.text);

      if (response == null) {
        _showError('خطا در دریافت اطلاعات از سرور');
      } else if (response.message == 'OK') {
        currentState.value = PageState.EnterCode;
      } else if (response.message == 'INVALID_ACCOUNT') {
        _showError('کاربر تا کنون ثبت نام نکرده است.');
      } else {
        _showError('خطا در دریافت اطلاعات از سرور');
      }
    } catch (e) {
      _showError('خطا در دریافت اطلاعات از سرور');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyResetPassword({
    required String password,
    required String cellNumber,
  }) async {
    isLoading.value = true;

    try {
      var response = await DioClient.instance.verifyResetPassword(
        password: password,
        cellNumber: cellNumber,
      );

      if (response == null) {
        _showError('خطا در دریافت اطلاعات از سرور');
      } else if (response.message == 'OK') {
        currentState.value = PageState.NewPassword;
      } else if (response.message == 'INVALID_PASSWORD') {
        _showError('کد وارد شده صحیح نیست');
      } else {
        _showError('خطا در دریافت اطلاعات از سرور');
      }
    } catch (e) {
      _showError('خطا در دریافت اطلاعات از سرور');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmOtp() async {
    isLoading.value = true;

    try {
      var response = await DioClient.instance.confirmOTP(
        password: otpCodeController.text.toEnglishDigit(),
        cellNumber: loginMobileNumberController.text.toEnglishDigit()
      );

      if (response == null) {
        _showError('خطا در دریافت اطلاعات از سرور');
      } else if (response.message == 'OK') {
        StorageHelper().setShortToken(response?.token ?? '');
        StorageHelper().setIsLogedIn(true);
        StorageHelper().setPhoneNumber(loginMobileNumberController.text);
        Get.offAllNamed(RouteName.home);
      } else if (response.message == 'INVALID_PASSWORD') {
        _showError('کد وارد شده صحیح نیست');
      } else {
        _showError('خطا در دریافت اطلاعات از سرور');
      }
    } catch (e) {
      _showError('خطا در دریافت اطلاعات از سرور');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmNewPassword() async {
    bool isValid = passwordFormKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    isLoading.value = true;

    try {
      var response = await DioClient.instance.confirmNewPassword(
        newPassword: passwordController.text,
        cellNumber: forgetMobileNumberController.text,
        code: codeController.text,
      );

      if (response == null) {
        _showError('خطا در دریافت اطلاعات از سرور');
      } else if (response.message == 'OK') {
        StorageHelper().setShortToken(response.token ?? '');
        StorageHelper().setIsLogedIn(true);
        StorageHelper().setPhoneNumber(forgetMobileNumberController.text);

        showToast(ToastState.SUCCESS, 'رمز عبور با موفقیت تغییرکرد');
        Get.offAllNamed(RouteName.home);
      } else if (response.message == 'INVALID_PASSWORD') {
        _showError('کد وارد شده صحیح نیست');
      } else {
        _showError('خطا $response');
      }
    } catch (e) {
      _showError('خطا در دریافت اطلاعات از سرور');
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(String message) {
    showToast(ToastState.ERROR, message);
  }

  void goBack() {
    switch (currentState.value) {
      case PageState.EnterPhoneNumber:
        Get.back();
        break;
      case PageState.EnterCode:
        currentState.value = PageState.EnterPhoneNumber;
        break;
      case PageState.NewPassword:
        currentState.value = PageState.EnterCode;
        break;
    }
  }

  Future<void> login( String password) async {
    isLoading.value = true;
    var response = await DioClient.instance.login(loginMobileNumberController.text, password).catchError(()=>isLoading.value=false);
    isLoading.value = false;
    if (response?.message == 'OK') {
      StorageHelper().setShortToken(response?.token ?? '');
      StorageHelper().setIsLogedIn(true);
      StorageHelper().setPhoneNumber(loginMobileNumberController.text);
      Get.offAllNamed(RouteName.home);
    }else{
      
    }
  }

  Future<void> sendOtp() async {
    isLoading.value = true;
    var response = await DioClient.instance
        .sendOTP(cellNumber: loginMobileNumberController.text.toEnglishDigit());
    if (response?.message == 'OK') {
      isLoading.value = false;
      currentPage.value=AuthPageState.otp;
      startTimer();
    } else {
      showToast(ToastState.ERROR,
          response?.persianMessage ?? 'خطا در دریافت اطلاعات');
      isLoading.value = false;
    }
  }

  Future<void> _loadProvinces() async {
    final response = await DioClient.instance.getProvinces();
    print(response?.toJson());
    if (response != null && response.message == 'OK') {
      geoNames.clear();
      response.geoNames?.forEach((element) {
        if (element.id != null && element.description != null) {
          geoNames[element.id!] = element.description!;
        }
      });
    }
  }

  Future<void> _loadCities() async {
    if (provinceId.value.isEmpty) return;

    final response = await DioClient.instance.getCities(provinceId.value);
    if (response?.message == 'OK') {
      geoCityNames.clear();
      response?.geoNames?.forEach((element) {
        if (element.id != null && element.description != null) {
          geoCityNames[element.id!] = element.description!;
        }
      });
    }
  }

// Add these observable states to your AuthController class
  var registerSuccess = false.obs;
  var codeConfirmationSuccess = false.obs;
  var errorMessage = ''.obs;

// Replace the existing register method with this implementation
  Future<void> register() async {
    if(cityId==null||cityId.isEmpty){
      showToast(
        ToastState.ERROR,
        'لطفاً استان و شهر خودرا انتخاب نمایید.',
      );
      return;
    }
    if (!hasConfirmedRules.value) {
      showToast(
        ToastState.ERROR,
        'لطفاً شرایط و قوانین را مطالعه کرده و تایید نمایید',
      );
      return;
    }
    bool isValid = false;

    if (userState.value == UserState.normal) {
      isValid = haghighiFormKey.currentState?.validate() ?? false;
    } else if (userState.value == UserState.legal) {
      isValid = legalFormKey.currentState?.validate() ?? false;
    }

    if (!isValid) {
      return;
    }
    isLoading.value = true;
    registerSuccess.value = false;
    errorMessage.value = '';

    try {
      var response = await DioClient.instance.register(
        name: userState.value == UserState.normal
            ? nameController.text
            : haNameController.text,
        lastName: userState.value == UserState.normal
            ? lastNameController.text
            : haLastNameController.text,
        orgName: coNameController.text,
        gender: userGender.value == Gender.male ? 'M' : 'F',
        orgNationalId: coNationalCodeController.text,
        geoNameId: cityId.value,
        nationalId: userState.value == UserState.normal
            ? nationalCodeController.text
            : haNationalCodeController.text,
        password: userState.value == UserState.normal
            ? passwordController.text
            : haPasswordController.text,
        cellNumber: userState.value == UserState.normal
            ? mobileNumberController.text
            : haMobileNumberController.text,
        referralCode: userState.value == UserState.normal
            ? referralCodeController.text
            : haReferralCodeController.text,
        isReal: userState.value == UserState.normal,
      );

      isLoading.value = false;

      if (response?.message == 'OK') {
        registerSuccess.value = true;
        setRegisterState(RegisterPageState.otp);
        startTimer();
      } else {
        showToast(
            ToastState.ERROR, response?.persianMessage ?? "خطا در ثبت اطلاعات");
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'خطا در دریافت اطلاعات از سرور';
    }
  }

// Add this new method for code confirmation
  Future<void> confirmCode() async {
    isLoading.value = true;
    codeConfirmationSuccess.value = false;
    errorMessage.value = '';

    try {
      var response = await DioClient.instance.confirmRegister(
        code: codeController.text.toEnglishDigit(),
        cellNumber: userState.value == UserState.normal
            ? mobileNumberController.text
            : haMobileNumberController.text,
        referralCode: userState.value == UserState.normal
            ? referralCodeController.text
            : haReferralCodeController.text,
      );

      isLoading.value = false;

      if (response == null) {
        errorMessage.value = 'خطا در دریافت اطلاعات از سرور';
      } else if (response.message == 'OK') {
        // Store token and set login state
        StorageHelper().setShortToken(response.token ?? '');
        StorageHelper().setIsLogedIn(true);
        StorageHelper().setPhoneNumber(userState.value == UserState.normal
            ? mobileNumberController.text
            : haMobileNumberController.text);

        codeConfirmationSuccess.value = true;

        // Navigate to home
        Get.offAllNamed(RouteName.home);

        // Log analytics event (if you have Firebase Analytics setup)
        // if (!kIsWeb) {
        //   await FirebaseAnalytics.instance.logEvent(name: 'register_key');
        // }
      } else if (response.message == 'INVALID_PASSWORD') {
        errorMessage.value = 'کد وارد شده اشتباه است';
      } else {
        errorMessage.value = response.message ?? 'خطا در تایید کد';
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'خطا در دریافت اطلاعات از سرور';
    }
  }

  // @override
  // void onClose() {
  //   nameController.dispose();
  //   lastNameController.dispose();
  //   nationalCodeController.dispose();
  //   mobileNumberController.dispose();
  //   passwordController.dispose();
  //   passwordRepeatController.dispose();
  //   referralCodeController.dispose();
  //   emailController.dispose();
  //   haNameController.dispose();
  //   haLastNameController.dispose();
  //   haNationalCodeController.dispose();
  //   haMobileNumberController.dispose();
  //   haPasswordController.dispose();
  //   haPasswordRepeatController.dispose();
  //   haReferralCodeController.dispose();
  //   haEmailController.dispose();
  //   coNameController.dispose();
  //   coNationalCodeController.dispose();
  //   codeController.dispose();
  //   _timer?.cancel();
  //
  //   super.onClose();
  // }

  Future<void> onProvinceChanged(String? province) async {
    selectedProvince.value = province ?? "";
    provinceId.value = province ?? '';
    selectedCity.value = null;
    geoCityNames.clear();
    await _loadCities();

  }

  void onCityChanged(String? city) {
    selectedCity.value = city ?? '';
    cityId.value = city ?? "";
  }

  var pinCode = ''.obs;
  var timeLeft = 120.obs;
  var canResend = false.obs;
  Timer? _timer;

  void startTimer() {
    timeLeft.value = 120;
    canResend.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value == 0) {
        canResend.value = true;
        timer.cancel();
      } else {
        timeLeft.value--;
      }
    });
  }

  String get formattedTime {
    final minutes = (timeLeft.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (timeLeft.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void onPinCompleted(String pin) {
    pinCode.value = pin;
    // Handle pin verification logic
  }
}

enum AuthPageState { welcome, login, register, forgetPassword,otp }

enum RegisterPageState { forms, otp }

enum UserState { normal, legal }

enum Gender { male, female }

enum OtpState { form, password }

enum PageState {
  EnterPhoneNumber,
  EnterCode,
  NewPassword,
}
