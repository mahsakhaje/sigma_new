import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expandable/expandable.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/models/questions_model.dart';
import 'package:sigma/pages/profile/frequent_questions/questions_controller.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class QuestionsPage extends StatelessWidget {
  final QuestionsController controller = Get.put(QuestionsController());

  QuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: Strings.questions,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: loading(),
          );
        } else {
          return Column(
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(Strings.sameQuestion,
                      fontWeight: FontWeight.bold, size: 16),
                ],
              ),
              SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.faqContents.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return buildQuestionRowItem(controller.faqContents[index]);
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget buildQuestionRowItem(FaqContents question) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white)),
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              iconColor: Colors.white,
              animationDuration: const Duration(milliseconds: 500),
            ),
            header: CustomText(
              (question.question ?? '').usePersianNumbers(),
              isRtl: true,
            ),
            collapsed: const SizedBox(),
            expanded: Row(
              children: [
                Flexible(
                  child: CustomText(
                    (question.response ?? '').usePersianNumbers(),
                    isRtl: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}