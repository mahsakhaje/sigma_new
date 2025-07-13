import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/models/calculate_loan_payments_response.dart';
import 'package:sigma/pages/buy_menu/buy_menu_page.dart';
import 'package:sigma/pages/buy_menu/loan/loan_page.dart';
import 'package:url_launcher/url_launcher.dart';

class CalculateLoanController extends GetxController {
  final moneyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isLoading = true.obs;
  final RxBool isCallingApi = false.obs;
  final RxMap<String, String> durations = <String, String>{}.obs;
  final RxString selectedDuration = ''.obs;
  final RxString selectedDurationId = ''.obs;
  final RxList<LoanPayments> loanPayments = <LoanPayments>[].obs;
  final RxString pdfLink = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLoanDurations();
  }

  @override
  void onClose() {
    moneyController.dispose();
    super.onClose();
  }

  Future<void> _loadLoanDurations() async {
    try {
      var response = await DioClient.instance.getLoanDuration();
      if (response != null && response.message == 'OK') {
        pdfLink.value = response.infoLink ?? '';
        response.loanDurations?.forEach((element) {
          durations[element.id ?? ''] = element.description ?? '';
        });
      }
    } catch (e) {
      // Handle error if needed
      print('Error loading loan durations: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onMoneyChanged(String value) {
    // Trigger UI update when money text changes
    update();
  }

  void onDurationChanged(String? value) {
    print('here9');
    print(value);
    if (value != null) {
      selectedDuration.value = value;
      selectedDurationId.value =value;

    }
  }

  Future<void> calculateLoanPayments() async {
    hideKeyboard(Get.context!);

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedDuration.value.isEmpty || moneyController.text.isEmpty) {
      showToast(ToastState.ERROR, 'لطفا مقادیر خواسته شده را تکمیل نمایید');
      return;
    }

    try {
      isCallingApi.value = true;

      var response = await DioClient.instance.calculateLoanPayment(
        moneyController.text.replaceAll(',', '').toEnglishDigit(),
        selectedDurationId.value,
      );

      if (response?.message == 'OK') {
        loanPayments.value = response?.loanPayments ?? [];
        // Show modal after a short delay
        Future.delayed(const Duration(milliseconds: 300), () {
          showLoanPaymentsModal();
        });
      }
    } catch (e) {
      // Handle error if needed
      print('Error calculating loan payments: $e');
    } finally {
      isCallingApi.value = false;
    }
  }

  void showLoanPaymentsModal() {
    Get.bottomSheet(
      LoanPaymentsModal(controller: this),
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
    );
  }

  void navigateToBuyOrder() {
    Get.toNamed(RouteName.buy,arguments: BuyState.NORMAL);
  }

  void openPdfLink() {
    if (kIsWeb) {
      launchUrl(
        Uri.tryParse(pdfLink.value)!,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      return;
    }
    Get.toNamed(RouteName.pdf, arguments:{'url': pdfLink.value});
  }
}