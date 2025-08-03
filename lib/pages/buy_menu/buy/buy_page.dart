import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_check_box.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/money_form.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/buy_menu/buy/buy_controller.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class BuyPage extends StatelessWidget {
  final BuyController controller = Get.put(BuyController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    return DarkBackgroundWidget(
      title: Strings.buyCar,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Obx(() => controller.isFirstLoading.value
            ? Center(child: loading())
            : _buildMainContent(context)),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(Strings.enterOrderDetail,
                size: 16, fontWeight: FontWeight.w500, isRtl: true),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  CustomBottomSheetAnimated.show(
                      context: Get.context!,
                      initialChildSize: 0.5,
                      child: Wrap(
                        children: [
                          _buildCheckboxOptions(),
                        ],
                      ));
                },
                child: SvgPicture.asset('assets/more.svg')),
          ],
        ),
        const SizedBox(height: 16),
        _buildBrandDropdown(),
        const SizedBox(height: 8),
        _buildModelTypeRow(),
        const SizedBox(height: 8),
        _buildYearRow(),
        const SizedBox(height: 8),
        _buildKilometerRow(),
        const SizedBox(height: 8),
        _buildColorRow(),
        const SizedBox(height: 8),
        _buildBudgetForm(context),
        const SizedBox(height: 4),
        _buildBudgetText(),
        const SizedBox(height: 8),
        _buildSubmitButton(context),
      ],
    );
  }

  Widget _buildBrandDropdown() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: Strings.city,
              largeFont: true,
              value: controller.selectedCity.value,
              items: controller.cities,
              isTurn: controller.turn.value == 0,
              onChanged: (String? str) => controller.onCitySelected(str))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'برند خودرو',
              isTurn: controller.turn.value == 1,
              value: controller.selectedBrand.value,
              items: controller.brands,
              onChanged: (String? str) => controller.onBrandSelected(str))),
        ),
      ],
    );
  }

  Widget _buildModelTypeRow() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'تیپ خودرو',
              value: controller.selectedCarType.value,
              items: controller.carTypes,
              isTurn: controller.turn.value == 3,
              onChanged: (String? str) => controller.onCarTypeSelected(str))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'مدل خودرو',
              isEng: true,
              value: controller.selectedCarModel.value,
              items: controller.carModels,
              isTurn: controller.turn.value == 2,
              onChanged: (String? str) => controller.onCarModelSelected(str))),
        ),
      ],
    );
  }

  Widget _buildYearRow() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'سال ساخت تا',
              value: controller.selectedToYear.value,
              isTurn: controller.turn.value == 5,
              items: controller.carTypeManufactureYearsTo,
              onChanged: (String? str) => controller.onToYearSelected(str))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'سال ساخت از',
              isTurn: controller.turn.value == 4,
              value: controller.selectedFromYear.value,
              items: controller.carTypeManufactureYearsFrom,
              onChanged: (String? str) {
                print('onChanged called with: $str'); // Add this debug line
                controller.onFromYearSelected(str);
              })),
        ),
      ],
    );
  }

  Widget _buildKilometerRow() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'کارکرد تا',
              value: controller.selectedKiloMeteTo.value,
              isTurn: controller.turn.value == 7,
              items: {
                for (var item in controller.kilometerTo.value) '$item': '$item'
              },
              onChanged: (String? str) =>
                  controller.onKilometerToSelected(str))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'کارکرد از',
              value: controller.selectedKiloMeterFrom.value,
              isTurn: controller.turn.value == 6,
              items: {
                for (var item in controller.kilometerFrom.value)
                  '$item': '$item'
              },
              onChanged: (String? str) =>
                  controller.onKilometerFromSelected(str))),
        ),
      ],
    );
  }

  Widget _buildColorRow() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'رنگ داخل خودرو',
              value: controller.selectedTrimColors.value,
              items: controller.trimColors,
              isTurn: controller.turn.value == 9,
              isRtl: true,
              onChanged: (String? str) => controller.onTrimColorSelected(str))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(() => CustomDropdown(
              hint: 'رنگ خودرو',
              value: controller.selectedColors.value,
              items: controller.colorsCars,
              isRtl: true,
              isTurn: controller.turn.value == 8,
              onChanged: (String? str) => controller.onColorSelected(str))),
        ),
      ],
    );
  }

  Widget _buildBudgetForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() => MoneyForm(
              controller.amountController,
              min: 100000000,
              max: 50000000000,
              autovalidateMode: controller.turn.value == 10
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              hintText: 'بودجه به تومان',
              onEditingComplete: () {
                _formKey.currentState!.validate();
                hideKeyboard(context);

              },
              onChanged: (str) => controller.onBudgetChanged(),
              isTurn: controller.turn.value == 10,
            )),
      ),
    );
  }

  Widget _buildBudgetText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: CustomText(
              controller.amountController.text.toWord() +
                  " " +
                  ((controller.amountController.text.isNotEmpty)
                      ? 'تومان'
                      : ''),
              isRtl: true),
        )
      ],
    );
  }

  Widget _buildCheckboxOptions() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText('موارد مشابه اطلاع داده شود.',
                  fontWeight: FontWeight.bold,
                  isRtl: true,
                  color: Colors.black87),
              const SizedBox(width: 8),
              Obx(() => CustomCheckBox(
                  value: controller.showSimilar.value,
                  isDark: true,
                  isBlue: true,
                  onChanged: (val) => controller.toggleShowSimilar(val)))
            ],
          ),
          Divider(
            color: AppColors.darkGrey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText('مایل به اخذ تسهیلات هستم.',
                  fontWeight: FontWeight.bold,
                  isRtl: true,
                  color: Colors.black87),
              const SizedBox(width: 8),
              Obx(() => CustomCheckBox(
                  isDark: true,
                  value: controller.wantsLoan.value,
                  isBlue: true,
                  onChanged: (val) => controller.toggleWantsLoan(val)))
            ],
          ),
          Divider(
            color: AppColors.darkGrey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText('مایل به تعویض هستم.',
                  fontWeight: FontWeight.bold,
                  isRtl: true,
                  color: Colors.black87),
              const SizedBox(width: 8),
              Obx(() => CustomCheckBox(
                  isDark: true,
                  isBlue: true,
                  value: controller.isSwap.value,
                  onChanged: (val) => controller.toggleIsSwap(val)))
            ],
          ),
          Obx(() => controller.isSwap.value
              ? Column(
                  children: [
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      controller.swapCommentController,
                      maxLen: 300,
                      isDark: true,
                      acceptAll: true,
                      hintText:
                          'توضیحات تعویض',
                    ),
                    const SizedBox(height: 8),
                  ],
                )
              : const SizedBox()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConfirmButton(() => Get.back(), 'تایید'),
          )
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: loading(),
            ),
          )
        : ConfirmButton(
            () => controller.submitForm(context, _formKey),
            'ثبت درخواست',
            borderRadius: 8,
            color: AppColors.blue,
            txtColor: Colors.white,
          ));
  }
}
