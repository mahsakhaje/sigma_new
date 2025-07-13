import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/questions_model.dart';

class QuestionsController extends GetxController {
  RxList<FaqContents> faqContents = <FaqContents>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      var response = await DioClient.instance.getAllQuestions();
      if (response != null && response.message == 'OK') {
        faqContents.value = response.faqContents ?? [];
      }
    } catch (e) {
      // Handle error, perhaps show a snackbar
      Get.snackbar('Error', 'Failed to load questions',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
