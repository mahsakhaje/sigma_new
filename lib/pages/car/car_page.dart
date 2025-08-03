import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';

import 'package:sigma/models/my_cars_model.dart';
import 'car_controller.dart';

class CarWidget extends StatelessWidget {
  final Cars? order;

  const CarWidget({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CarController());

    controller.init(order);

    return DarkBackgroundWidget(
        title: 'مشخصات خودرو',
        child: Obx(() {
          if (controller.firstLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return controller.pageState.value == PageState.Confirm
              ? _buildFormFields(controller)
              : _buildEstelam(controller);
        }));
  }

  Widget _shasiForm(CarController controller) {
    return Form(
      key: controller.formKey,
      child: CustomTextFormField(
        controller.shasiController,
        maxLen: 17,
        hintText: 'شماره شاسی',
        // isChassiNumber: true,
        // validator: controller.validate,
        // exaxtLen: 17,
        autovalidateMode: controller.shasiController.text.length == 17
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        onChanged: controller.onShasiChanged,
        //errorText: 'شماره شاسی را به صورت صحیح وارد نمایید',
      ),
    );
  }

  Widget _buildDropdownRow1(CarController controller) {
    return Row(
      children: [
        Expanded(
            child: Obx(() => CustomDropdown(
                  hint: 'برند خودرو',
                  value: controller.selectedBrand.value,
                  items: controller.brands,
                  isTurn: controller.turn.value == 2,
                  onChanged: controller.onBrandChanged,
                ))),
        const SizedBox(width: 12),
        Expanded(
            child: Obx(() => CustomDropdown(
                  hint: 'مدل خودرو',
                  value: controller.selectedCarModel.value,
                  items: controller.carModels,
                  isEng: true,
                  isTurn: controller.turn.value == 3,
                  onChanged: controller.onModelChanged,
                ))),
      ],
    );
  }

  Widget _buildDropdownRow2(CarController controller) {
    return Row(
      children: [
        Expanded(
            child: Obx(() => CustomDropdown(
                  hint: 'تیپ خودرو',
                  value: controller.selectedCarType.value,
                  items: controller.carTypes,
                  isTurn: controller.turn.value == 4,
                  onChanged: controller.onTypeChanged,
                ))),
        const SizedBox(width: 12),
        Expanded(
            child: Obx(() => CustomDropdown(
                  hint: 'سال ساخت',
                  value: controller.selectedFromYear.value,
                  items: controller.carTypeManufactureYears,
                  isTurn: controller.turn.value == 5,
                  onChanged: controller.onYearChanged,
                ))),
      ],
    );
  }

  Widget _buildDropdownRow3(CarController controller) {
    return Row(
      children: [
        Expanded(
            child: Obx(() => CustomDropdown(
                  hint: 'رنگ خودرو',
                  value: controller.selectedColors.value,
                  items: controller.colorsCars,
                  isRtl: true,
                  isTurn: controller.turn.value == 6,
                  onChanged: controller.onColorChanged,
                ))),
        const SizedBox(width: 12),
        Expanded(
            child: Obx(() => CustomDropdown(
                  hint: 'رنگ داخل خودرو',
                  value: controller.selectedTrimColors.value,
                  items: controller.trimColors,
                  isRtl: true,
                  isTurn: controller.turn.value == 7,
                  onChanged: controller.onTrimColorChanged,
                ))),
      ],
    );
  }

  _buildFormFields(CarController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            CustomText('لطفا جزئیات خودروی مورد نظر را وارد نمائید:',
                isRtl: true, size: 16, fontWeight: FontWeight.bold),
            SizedBox(
              height: 32,
            ),
            _shasiForm(controller),
            const SizedBox(height: 8),
            _buildDropdownRow1(controller),
            const SizedBox(height: 8),
            _buildDropdownRow2(controller),
            const SizedBox(height: 8),
            _buildDropdownRow3(controller),
            const SizedBox(height: 16),
            ConfirmButton(
              controller.confirm,
              order == null ? 'افزودن' : 'ذخیره تغییرات',
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEstelam(CarController controller) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          CustomText('استعلام مشخصات خودرو',
              size: 20, fontWeight: FontWeight.bold),
          const SizedBox(height: 46),
          _shasiForm(controller),
          const SizedBox(height: 16),
          CustomText(
            'اطلاعات خودروی شما از بانک اطلاعاتی کرمان موتور خوانده می‌شود، در صورت مغایرت آن را ویرایش نمایید.',
            isRtl: true,
            maxLine: 3,
          ),
          const SizedBox(height: 46),
          Obx(() => controller.isLoading.value
              ? const CircularProgressIndicator()
              : ConfirmButton(
                  controller.inquiry,
                  'ادامه',
                )),
        ],
      ),
    );
  }
}
