import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/compare_cars/compare_cars_controller.dart';

import '../../models/car_detail_response.dart';

class CompareCarsPage extends GetView<CompareCarsController> {
  const CompareCarsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: 'مقایسه آگهی',
      child: Obx(() => controller.isLoading.value
          ?  Center(child: loading())
          : _buildComparisonContent()),
    );
  }

  Widget _buildComparisonContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // const SizedBox(height: 16),
          // _buildComparisonTitle(),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: _buildComparisonCards(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildComparisonTitle() {
    return Center(
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Obx(() => CustomText(controller.comparisonTitle)),
        ),
      ),
    );
  }

  Widget _buildComparisonCards() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: _InfoCard(
                order: controller.secondDetail.value?.salesOrder,
                bgColor: Colors.white,
                hasDelete: true,
                onDelete: controller.removeSecondCar,
                onAddPressed: controller.navigateBack,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _InfoCard(
                order: controller.firstDetail.value?.salesOrder,
                bgColor: Colors.white,
                hasDelete: false,
                onAddPressed: controller.navigateBack,
              ),
            ),
          ],
        ));
  }
}

// Separate Widget for Info Card
class _InfoCard extends StatelessWidget {
  final SalesOrder? order;
  final Color bgColor;
  final bool hasDelete;
  final VoidCallback? onDelete;
  final VoidCallback onAddPressed;

  const _InfoCard({
    Key? key,
    required this.order,
    required this.bgColor,
    required this.hasDelete,
    this.onDelete,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: order == null ? _buildAddCarSection() : _buildCarDetailsSection(),
    );
  }

  Widget _buildAddCarSection() {
    return Center(
      child: InkWell(
        onTap: onAddPressed,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.blue),
            borderRadius: BorderRadius.circular(5),
          ),
          child: CustomText(
            'افزودن آگهی',
            color: AppColors.blue,
            size: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCarDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildHeader(),
        Expanded(child: _buildCarDetails()),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(8),
      color: hasDelete ? AppColors.darkGrey : AppColors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          hasDelete
              ? Container(
                  margin: EdgeInsets.all(8), child: _buildDeleteButton())
              : Container(),
          CustomText(
              '${order?.brandDescription ?? ''} ${order?.carModelDescription ?? ''}',
              size: 16,
              fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: onDelete,
      child: Center(
        child: Container(
         // padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
          ),
          child: Center(
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarDetails() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 12),
          _buildSectionTitle('مشخصات عمومی'),
          const SizedBox(height: 12),
          _buildGeneralSpecs(),
          const SizedBox(height: 16),
          Divider(color: AppColors.darkGrey),
          const SizedBox(height: 12),
          _buildSectionTitle('مشخصات فنی'),
          const SizedBox(height: 12),
          _buildTechnicalSpecs(),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CustomText(
      title,
      size: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
  }

  Widget _buildGeneralSpecs() {
    return Column(
      children: [
        _buildSpecRow(
          'قیمت',
          NumberUtils.separateThousand(
            int.tryParse(order?.advertiseAmount ?? '0'.usePersianNumbers()) ??
                0,
          ).usePersianNumbers(),
        ),
        const SizedBox(height: 6),
        const DottedLine(),
        const SizedBox(height: 6),
        _buildSpecRow(
          'کارکرد',
          NumberUtils.separateThousand(
            int.tryParse(order?.mileage ?? '0'.usePersianNumbers()) ?? 0,
          ).usePersianNumbers(),
        ),
        const SizedBox(height: 6),
        const DottedLine(),
        const SizedBox(height: 6),
        _buildSpecRow(
          'سال ساخت',
          (order?.persianYear ?? '0').usePersianNumbers(),
        ),
      ],
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          value,
          color: Colors.black,
          size: 15,
          fontWeight: FontWeight.bold,
        ),
        CustomText(label, color: Colors.black, size: 15),
      ],
    );
  }

  Widget _buildTechnicalSpecs() {
    final specs = order?.carTypeDefaultSpecTypes ?? [];

    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (ctx, index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: const DottedLine(),
        ),
        itemCount: specs.length,
        itemBuilder: (ctx, index) => _buildTechnicalSpecItem(specs[index]),
      ),
    );
  }

  Widget _buildTechnicalSpecItem(dynamic spec) {
    return Column(
      children: [
        CustomText(
          spec.specTypeDescription ?? "",
          color: Colors.black,
          size: 14,
          isRtl: true,
          maxLine: 1,
        ),
        const SizedBox(height: 10),
        CustomText(
          spec.description ?? "",
          color: Colors.black,
          size: 12,
          isRtl: true,
          maxLine: 3,
        ),
      ],
    );
  }
}

// Model

// Binding
