import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/published_transaction_response.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/pages/transactions/all_transactions_controller.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class AllTransactionsPage extends StatelessWidget {
  final controller = Get.put(AllTransactionsController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: Strings.sigmaTransactions,
      child: Obx(() {
        if (controller.isLoading.value && controller.transactions.isEmpty) {
          return Center(child: loading());
        }

        if (controller.transactions.isEmpty) {
          return NoContent();
        }

        return GridView.builder(
          padding: EdgeInsets.all(8),
          controller: controller.scrollController,
          itemCount: controller.hasMore.value
              ? controller.transactions.length + 1
              : controller.transactions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (ctx, index) {
            if (index == controller.transactions.length) {
              return Center(child: loading());
            }
            return TransactionOrderItemWidget(controller.transactions[index]);
          },
        );
      }),
    );
  }

  Widget TransactionOrderItemWidget(Transactions order) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: order.documents == null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(cardBorderRadius() - 4),
                        child: Container(
                          color: AppColors.lightGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SvgPicture.asset(
                              'assets/no_pic.svg',
                              height: 110,
                            ),
                          ),
                        ))
                    : ClipRRect(
                        borderRadius:
                            BorderRadius.circular(cardBorderRadius() - 4),
                        child: Image.network(
                          height: 110,
                          '${URLs.imageLinks}${order.documents?[0].id ?? ""}',
                          fit: BoxFit.fitWidth,
                        )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(order.typeText ?? '', color: AppColors.darkGrey),
                CustomText('  فروش     ' , color: AppColors.darkGrey),
                CustomText(order.brandDescription ?? '',
                    color: Colors.black87, size: 14, fontWeight: FontWeight.bold),
                CustomText('-'),
                CustomText((order.carModelDescription ?? ''),
                    color: Colors.black87, size: 14, fontWeight: FontWeight.bold),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText('${order.persianYear}'.usePersianNumbers(),
                    color: Colors.black87, size: 10),
                CustomText('${order.colorDescription}'.usePersianNumbers(),
                    color: Colors.black87, size: 10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: CustomText(
                (order.description ?? '')
                    .replaceAll('\n', ' ')
                    .usePersianNumbers(),
                color: Colors.black87,
                maxLine: 2,
                isRtl: true,
                textAlign: kIsWeb ? TextAlign.right : TextAlign.justify,
                size: 10),
          ),
          Divider(
            color: AppColors.lightGrey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText((order.transactionDate ?? '').usePersianNumbers(),
                    color: AppColors.darkGrey, size: 10),
                CustomText(' :  ',
                    color: AppColors.darkGrey, fontWeight: FontWeight.bold),
                CustomText('تاریخ فروش', color: AppColors.darkGrey, size: 10)
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
