import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';

import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/privacy/privacy_rules_controller.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

// Import your controller here
// import 'privacy_rules_controller.dart';

class PrivacyRulesPage extends StatelessWidget {
  const PrivacyRulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(PrivacyRulesController());

    return DarkBackgroundWidget(
      title: 'حریم خصوصی',
      child: Obx(() {
        if (controller.isLoading) {
          return  Center(
            child: loading(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: HtmlWidget(
              (   controller.response?.manaRule?.description ?? '').usePersianNumbers(),
              textStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Peyda'
              ),
              customWidgetBuilder: (element) {
                if (element.localName == 'li') {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 14,
                            width: 14,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.blue,
                            ),
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: CustomText(
                          '${element.text.replaceFirst('\n', '')}',
                          isRtl: true,

                        ),
                      ),
                    ],
                  );
                }
                return null;
              },
              customStylesBuilder: (element) {
                return {
                  'text-align': UniversalPlatform.isWeb ? 'right' : 'justify',
                };
              },
            ),
          ),
        );
      }),
    );
  }
}
