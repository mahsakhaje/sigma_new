import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/map.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'branches_controller.dart';

class BranchesPage extends StatelessWidget {
  BranchesPage({super.key});

  final BranchesController controller = Get.put(BranchesController());

  @override
  Widget build(BuildContext context) {
    if (controller.showDialog.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showBranchesModal(context, controller);
      });
    }
    return DarkBackgroundWidget(
      title: 'شعب سیگما',
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: loading());
        }

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  _buildCitySelector(controller),
                  const SizedBox(height: 12),
                  Expanded(child: _buildMap(controller)),
                  const SizedBox(height: 26),
                  _buildBranchInfo(controller),
                ],
              ),
            ),
            _buildBottomSheet(context, controller),
          ],
        );
      }),
    );
  }

  Widget _buildCitySelector(BranchesController controller) {
    return SizedBox(
      height: 56,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.cities.length,
            itemBuilder: (context, index) {
              final cityName = controller.cities.values.elementAt(index);
              return _buildCityWidget(controller, index, cityName);
            },
          );
        }),
      ),
    );
  }

  Widget _buildCityWidget(
      BranchesController controller, int index, String cityName) {
    return Obx(() {
      final isSelected = index == controller.selectedCityIndex.value;

      return InkWell(
        onTap: () {
          controller.selectCity(index);
          showBranchesModal(Get.context!, controller);
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: isSelected ? AppColors.blue : AppColors.grey,
          ),
          child: Center(
            child: CustomText('شعبه $cityName',
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }

  Widget _buildMap(BranchesController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: MapScreen(),
    );
  }

  Widget _buildBranchInfo(BranchesController controller) {
    return Obx(() {
      final selectedBranch = controller.selectedBranch;

      if (selectedBranch == null) {
        return CustomText('شعبه ای انتخاب نشد');
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            (selectedBranch.address ?? '').usePersianNumbers(),
            isRtl: true,
            size: 14,
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (selectedBranch.telNumber ?? '')
                .split('-')
                .where((number) => number.trim().isNotEmpty)
                .map((phoneNumber) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SizedBox(
                width: 140,
                child: showRoomNumber(phoneNumber.trim()),
              ),
            ))
                .toList(),
          ),
          const SizedBox(height: 48),
        ],
      );
    });
  }

  Widget showRoomNumber(String number, {bool isLite = false}) {
    return InkWell(
      onTap: () async {
        if (number.isNotEmpty) {
          final Uri launchUri = Uri(
            scheme: 'tel',
            path: number,
          );
          await launchUrl(launchUri);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.lightGrey),
        child: Wrap(
          children: [
            Icon(
              Icons.call_outlined,
              size: 18,
              color: isLite ? Colors.black : Colors.white,
            ),

            CustomText(
              number.usePersianNumbers(),
              color: isLite ? Colors.black : Colors.white,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(
      BuildContext context, BranchesController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () => showBranchesModal(context, controller),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_upward_outlined,
                    color: Colors.black87,
                    size: 12,
                  ),
                  CustomText('انتخاب سایر شعب',
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showBranchesModal(
      BuildContext context, BranchesController controller) async {
    var a = await CustomBottomSheet.show(
      context: Get.context!,
      initialChildSize:controller.branchesInDialog.length==1?0.4: 0.6,
      child: Column(
        children: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.builder(
                itemCount: controller.branchesInDialog.length,
              physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildBranchListItem(controller, index);
                },
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ConfirmButton(
                  () {
                controller.launchNavigation();
                Get.back();
              },
              'مسیریابی',
              color: AppColors.blue,
              txtColor: Colors.white,
            ),
          ),
        ],
      ),
    );
    controller.showDialog.value = false;
  }

  Widget _buildBranchListItem(BranchesController controller, int index) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black54),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Theme(
          data: Get.theme.copyWith(dividerColor: Colors.transparent),
          child: Obx(() {
            final branch = controller.branchesInDialog[index];
            final isSelected = controller.selectedBranchIndex.value == index;

            return ExpansionTile(

              title: RadioListTile<int>(
                value: index,

                activeColor: AppColors.blue,
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.blue; // selected color
                  }
                  return AppColors.blue;// unselected color
                }),
                groupValue: controller.selectedBranchIndex.value,
                onChanged: (int? value) {
                  if (value != null) {
                    controller.selectBranch(value);
                  }
                },
                title: Row(
                  children: [
                    CustomText(
                      (branch.name ?? '').usePersianNumbers(),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 11,
                    ),
                  ],
                ),
              ),
              key: ValueKey(index),
              initiallyExpanded: isSelected,
              children: [
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CustomText(
                          (branch.address ?? '').usePersianNumbers(),
                          color: Colors.black,
                          isRtl: true,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.bold,
                          maxLine: 2,
                          size: 11
                        ),
                      ),
                    ),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Wrap(
                   // crossAxisAlignment: CrossAxisAlignment.start,
                    children: (branch.telNumber ?? '')
                        .split('-')
                        .where((number) => number.trim().isNotEmpty)
                        .map((phoneNumber) => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: SizedBox(
                        width: 140,
                        child: showRoomNumber(phoneNumber.trim(),isLite: true),
                      ),
                    ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            );
          }),
        ),
      ),
    );
  }
}
