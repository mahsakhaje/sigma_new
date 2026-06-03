import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/global_custom_widgets/badge.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/models/payments_model.dart';
import 'package:sigma/pages/profile/payments/payments_controller.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentsController controller = Get.put(PaymentsController());

    return DarkBackgroundWidget(
        child: Obx(() {
          return controller.loading.value
              ? Center(
                  child: loading(),
                )
              : controller.payments.length == 0
                  ? Center(
                      child: NoContent(),
                    )
                  : ListView.builder(
                      itemCount: controller.payments.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (ctx, index) {
                        return payment(controller.payments[index]);
                      });
        }),
        title: Strings.myPayments);
  }

  Widget payment(Payment payment) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),

        child:Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                badge(payment.bankStatus == '1' ? 'موفق' : 'ناموفق',color: payment.bankStatus == '1' ? AppColors.greenChart:AppColors.orange),
                const Spacer(),
                if(payment.bankStatus == '1' )  Row(
                  children: [
                    CustomText((payment.bankFactorNumber ?? '').usePersianNumbers(),
                        isRtl: true,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                    CustomText(' : ',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        isRtl: true),
                    CustomText('شماره فاکتور',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        isRtl: true),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          if(payment.bankStatus == '1' )  Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CustomText((payment.bankCardNumber ?? '').usePersianNumbers(),
                  textAlign: TextAlign.center,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                CustomText('شماره کارت بانکی',
                  textAlign: TextAlign.center,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Divider(color: AppColors.lightGrey,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                data('تاریخ پرداخت', payment.registerDate ?? ''),
                data('ساعت پرداخت', payment.registerTime ?? ''),
                data('مبلغ', (payment.amount ?? '').seRagham()+' تومان ')
              ],
            )
          ],
        )

      ),
    );
  }

  Widget data(String title, String value) {
    return Column(
      children: [
        CustomText(title, color: Colors.black87, fontWeight: FontWeight.bold),
        SizedBox(height: 6,),
        CustomText(value.usePersianNumbers(), color: Colors.black87,isRtl: true)
      ],
    );
  }
}
