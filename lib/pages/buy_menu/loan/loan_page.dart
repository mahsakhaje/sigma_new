import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/money_form.dart';
import 'package:sigma/global_custom_widgets/outlined_button.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/models/calculate_loan_payments_response.dart';
import 'package:sigma/pages/buy_menu/loan/loan_controller.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class CalculateLoanPage extends StatelessWidget {
  const CalculateLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CalculateLoanController controller =
        Get.put(CalculateLoanController());

    return DarkBackgroundWidget(
      title: 'تسهیلات',
      child: Obx(() {
        if (controller.isLoading.value) {
          return  Center(child: loading());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      'مبلغ تسهیلات باید بین 50 تا 300 میلیون تومان باشد.'
                          .usePersianNumbers(),
                      size: 16,
                      isRtl: true
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                const SizedBox(height: 8),
                Form(
                  key: controller.formKey,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: MoneyForm(
                      controller.moneyController,
                      maxLen: 11,
                      onChanged: controller.onMoneyChanged,
                      min: 50000000,
                      max: 300000000,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GetBuilder<CalculateLoanController>(
                  builder: (controller) => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: CustomText(
                          controller.moneyController.text.toWord() +
                              " " +
                              ((controller.moneyController.text.isNotEmpty)
                                  ? 'تومان'
                                  : ''),
                          isRtl: true,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 8),
                Obx(() => CustomDropdown(
                      hint: 'مدت بازپرداخت اقساط',
                      value: controller.selectedDuration.value.isEmpty
                          ? null
                          : controller.selectedDuration.value,
                      items: controller.durations,
                      onChanged: controller.onDurationChanged,
                    )),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: controller.openPdfLink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        'شرایط و مراحل دریافت وام',
                        size: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 8,),
                      SvgPicture.asset('assets/download.svg'),

                    ],
                  ),
                ),
                const SizedBox(height: 72),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => controller.isCallingApi.value
                          ?  Center(child: loading())
                          : ConfirmButton(
                              controller.calculateLoanPayments,
                              'محاسبه اقساط',
                            )),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: customOutlinedButton(
                        controller.navigateToBuyOrder,
                        'ثبت سفارش خرید',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class LoanPaymentsModal extends StatelessWidget {
  final CalculateLoanController controller;

  const LoanPaymentsModal({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.highlight_remove_outlined,
                      size: 28,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      '${controller.moneyController.text} تومان',
                      color: Colors.black87,
                      isRtl: true,
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      'مبلغ اصل وام',
                      color: Colors.black87,
                      isRtl: true,
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => CustomText(
                          controller.durations.value[controller.selectedDurationId.value??""]??"",
                          color: Colors.black87,
                          isRtl: true,
                          size: 12,
                          fontWeight: FontWeight.bold,
                        )),
                    CustomText(
                      'تعداد اقساط',
                      color: Colors.black87,
                      isRtl: true,
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              const DottedLine(),
              const SizedBox(height: 8),
              Expanded(
                child: Obx(() => ListView.separated(
                      controller: scrollController,
                      itemCount: controller.loanPayments.length,
                      separatorBuilder: (ctx, indx) =>
                          const SizedBox(height: 26),
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return loanPaymentDescription(
                          context,
                          controller.loanPayments[index],
                        );
                      },
                    )),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

Widget loanPaymentDescription(
    BuildContext context, LoanPayments? loanPayments) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        ' : ${loanPayments?.description ?? ''}',
        color: Colors.black87,
        size: 14,
        fontWeight: FontWeight.bold,
      ),
      CustomText(
        '${(loanPayments?.amount ?? '').seRagham().usePersianNumbers()} تومان ',
        color: Colors.black87,
        isRtl: true,
        size: 12,
        fontWeight: FontWeight.bold,
      ),
    ],
  );
}
