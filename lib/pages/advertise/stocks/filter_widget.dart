import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/advertise/stocks/stocks_controller.dart';

class StocksFilterWidget extends StatelessWidget {
  final StocksController controller;

  const StocksFilterWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBrandFilter(),
              SizedBox(height: 16),
              _buildModelFilter(),
             controller.tab==TabStatus.TOTAL?SizedBox():_buildUsualFilter()
            ],
          ),
          Divider(height: 1),
          _buildFilterActions(),
        ],
      ),
    );
  }


Widget _buildUsualFilter(){
    return Column(
      children: [
        SizedBox(height: 16),

        _buildTypeFilter(),
        SizedBox(height: 16),
        _buildYearFilter(),
        SizedBox(height: 16),
        _buildColorFilter(),
        SizedBox(height: 16),
        _buildMileageFilter(),
      ],
    );
}
  Widget _buildBrandFilter() {
    return Obx(() => CustomDropdown(
      hint: 'برند',
      value: controller.selectedBrandId?.value,
      items: controller.brands.value,
      onChanged: controller.selectBrand,
      isDark: true
    ));
  }

  Widget _buildModelFilter() {
    return Obx(() => CustomDropdown(
      hint: 'مدل خودرو',
      value: controller.selectedModelId?.value,
      items: controller.carModels.value,
      onChanged: controller.selectModel,
        isDark: true

    ));
  }

  Widget _buildTypeFilter() {
    return Obx(() => CustomDropdown(
      hint: 'تیپ خودرو',
      value: controller.selectedTypeId?.value,
      items: controller.carTypes,
      onChanged: controller.selectType,
        isDark: true

    ));
  }

  Widget _buildYearFilter() {
    return Obx(() => CustomDropdown(
      hint: 'سال ساخت',
      value: controller.selectedYear.value,
      items: controller.carManufactureYears.value,
      onChanged: controller.selectYear,
      isDark: true
    ));
  }  Widget _buildColorFilter() {
    return Obx(() => CustomDropdown(
      hint: 'رنگ خودرو',
      value: controller.selectedColorId.value,
      items: controller.colors.value,
      onChanged: controller.selectColor,
      isDark: true
    ));
  }

  Widget _buildMileageFilter() {
    return Obx(() => CustomDropdown(
      hint: 'وضعیت کارکرد',
      value: controller.selectedMileage.value,
      items: controller.mileageState,
      onChanged: controller.selectMileage,
      isDark: true
    ));
  }



  String _getPreviousFilterName(String currentFilter) {
    if (currentFilter == 'مدل خودرو') return 'برند';
    if (currentFilter == 'تیپ خودرو') return 'مدل';
    return '';
  }

  Widget _buildFilterActions() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => OutlinedButton(
              onPressed: controller.hasActiveFilters
                  ? controller.resetFilters
                  : null,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(
                  color: controller.hasActiveFilters
                      ? Colors.black
                      : AppColors.darkGrey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: CustomText(
                'حذف همه',
                color: controller.hasActiveFilters
                    ? Colors.black
                    : AppColors.darkGrey,
              ),
            )),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: (){ controller.getStocks();
                Get.back();
                },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: CustomText(
                'اعمال فیلتر',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}