import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/pages/suggestions/suggestions_controller.dart';

class SuggestionPage extends StatelessWidget {
  SuggestionPage({super.key});

  final SuggestionController controller = Get.put(SuggestionController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: 'انتقادات و پیشنهادات',
      child: Obx(() {
        if (controller.isLoading.value) {
          return  Center(child: loading());
        }

        if (controller.suggestionTypes.isEmpty) {
          return const Center(child: Text('هیچ گزینه‌ای یافت نشد'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 26),
              CustomText(
                  'کاربر گرامی جهت بهبود ارائه خدمات،لطفا انتقادات و پیشنهادات خودتان را برای ما ارسال کنید:  ',
                  isRtl: true,
                  fontWeight: FontWeight.bold,
                  size: 16,
                  textAlign: TextAlign.center),
              const SizedBox(height: 36),
              buildSuggestionTypeDropdown(),
              const SizedBox(height: 66),
              CustomText('یادداشت خود را برای ما بنویسید:',
                  isRtl: true, fontWeight: FontWeight.bold, size: 16),
              const SizedBox(height: 8),
              _buildCommentBox(),
              const SizedBox(height: 16),
              ConfirmButton(
                () => controller.submitSuggestion(context),
                'ثبت و ارسال نظر',
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildSuggestionTypeDropdown() {
    final Map<String, String> suggestionTypeMap = {
      for (int i = 0; i < controller.suggestionTypes.length; i++)
        i.toString(): controller.suggestionTypes[i].description ?? ''
    };

    return Obx(() {
      String? selectedKey = controller.selectedIndex.value.toString();

      return CustomDropdown(
        hint: 'انتخاب واحد',
        value: suggestionTypeMap.containsKey(selectedKey) ? selectedKey : null,
        items: suggestionTypeMap,
        onChanged: (String? newVal) {
          if (newVal != null) {
            controller.selectedIndex.value = int.parse(newVal);
          }
        },
        isRtl: true,
        isDark: false,
        largeFont: true,
        // or true based on theme
        isFullLine: true,
      );
    });
  }

  Widget _buildCommentBox() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: controller.formKey,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.commentController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    textDirection: TextDirection.rtl,
                    style:
                        const TextStyle(color: Colors.white, fontFamily: 'Peyda'),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: ' یادداشت خود را وارد کنید...',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: controller.clearComment,
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(Icons.delete_outline_outlined,
                      size: 28, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
