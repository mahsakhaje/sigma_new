import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/models/mana_prices_response.dart';
import 'package:sigma/pages/technicalInfo/technicalInfro_controller.dart';

class TechnicalInfoPage extends StatelessWidget {
  const TechnicalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TechnicalInfoController controller =
        Get.put(TechnicalInfoController());

    return DarkBackgroundWidget(
        child: Obx(() {
          return _buildBody(controller);
        }),
        title: Strings.technicalInfo);
  }

  Widget _buildBody(TechnicalInfoController controller) {
    if (controller.isLoading.value) {
      return Center(
        child: loading(),
      );
    }
    if (controller.manaPrices.isEmpty) {
      return NoContent();
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
          itemCount: controller.manaPrices.length,
          controller: controller.scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (ctx, index) {
            return _carItemWidget(controller.manaPrices[index], controller);
          }),
    );
  }

  _carItemWidget(ManaPrices manaPric, TechnicalInfoController controller) {
    return Obx(()=> GestureDetector(
      onTap: () => controller.onCarTapped(manaPric.carTypeId.toString() ?? '', manaPric.imagePath ?? '',
          manaPric.carModel ?? ''),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color:controller.firstId==manaPric.carTypeId && controller.isChooingMode.value?Colors.grey.withOpacity(0.2): Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            manaPric.imagePath == null
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Container(
                      color: AppColors.lightGrey,
                      height: 120,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 36, horizontal: 18),
                        child: SvgPicture.asset('assets/no_pic.svg'),
                      ),
                    ))
                : ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Image.network(
                      manaPric.imagePath ?? "",
                      fit: BoxFit.cover,
                      width: Get.width,
                      height: 120,
                    )),
            SizedBox(
              height: 10,
            ),
            CustomText((manaPric.carModelPersian ?? ''),
                color: Colors.black, size: 16, fontWeight: FontWeight.bold,isRtl: true),
            SizedBox(
              height: 10,
            ),
      !controller.isChooingMode.value ?     Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 44,
                child: ConfirmButton(
                  () => controller.showCarSpecsDialog(
                      manaPric.carTypeId.toString() ?? '',
                      manaPric.carModel ?? '',
                      manaPric.imagePath ?? ''),
                  Strings.technicalInfo,
                  color: Colors.black,
                  txtColor: Colors.white,
                ),
              ),
            ):SizedBox()
          ],
        ),
      ),
    ));
  }
}
