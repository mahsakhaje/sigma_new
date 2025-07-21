import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/suggestiontypes_model.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:sigma/helper/helper.dart';

class SuggestionController extends GetxController {
  final commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var suggestionTypes = <SuggestionTypes>[].obs;
  var isLoading = true.obs;
  var selectedIndex = RxnInt();

  @override
  void onInit() {
    super.onInit();
    fetchSuggestionTypes();
  }

  void fetchSuggestionTypes() async {
    isLoading.value = true;
    final response = await DioClient.instance.getSuggestionTypes();
    if (response != null && response.message == 'OK') {
      suggestionTypes.value = response.suggestionTypes ?? [];
    }
    isLoading.value = false;
  }

  void clearComment() {
    commentController.clear();
  }

  void submitSuggestion(BuildContext context) async {
    hideKeyboard(context);

    if (commentController.text.isEmpty) {
      showToast(ToastState.ERROR, 'متن پیشنهاد نمیتواند خالی باشد');
      return;
    }

    if (!formKey.currentState!.validate()) return;

    if (selectedIndex.value == null || selectedIndex.value! < 0) {
      showToast(ToastState.ERROR, 'لطفا نوع انتقاد یا پیشنهاد خود را انتخاب نمایید');
      return;
    }

    final response = await DioClient.instance.insertSuggestion(
      id: suggestionTypes[selectedIndex.value!].id ?? '',
      comment: commentController.text,
    );

    if (response?.message == 'OK') {
      showToast(ToastState.SUCCESS, 'نظر شما با موفقیت ثبت شد', isIos: UniversalPlatform.isIOS);
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
    } else {
      showToast(ToastState.ERROR, 'خطا در ثبت اطلاعات', isIos: UniversalPlatform.isIOS);
    }
  }
}
