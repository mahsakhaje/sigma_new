import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/Infoes/info_controller.dart';
import 'package:sigma/pages/Infoes/infoes_item_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final InfoController controller = Get.put(InfoController());

    return DarkBackgroundWidget(
      title: Strings.info,
      child: Obx(() {
        if (controller.isLoading.value) {
          return  Center(child: loading());
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              CustomText(
                Strings.seeAllInfoes,
                size: 14,
                fontWeight: FontWeight.bold,
                isRtl: true
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.infos.length,
                  itemBuilder: (ctx, index) {
                    return infoBanner(context, controller.infos[index]);
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
