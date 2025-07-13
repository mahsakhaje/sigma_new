import 'package:flutter/material.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';

class RequestCard extends StatelessWidget {
  final String trackingCode;
  final String status;
  final String carName;
  final String carModel;
  final String carEngine;
  final String carColor;
  final String carYear;
  final VoidCallback? onProposalsPressed;

  const RequestCard(
      {super.key,
      required this.trackingCode,
      required this.status,
      required this.carName,
      required this.carModel,
      required this.carEngine,
      required this.carColor,
      required this.carYear,
      required this.onProposalsPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
               InkWell(
                 onTap: onProposalsPressed,
                 child: CircleAvatar(

                     radius: 12,child: Icon(Icons.more_horiz_rounded),backgroundColor: AppColors.lightGrey,),
               ),
                const SizedBox(width: 8),
                status.length> 1?    Container(
                 padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText(
                    status,
                      color: AppColors.orange,
                      fontWeight: FontWeight.bold,
                      isRtl: true),

                ):SizedBox(),
                const Spacer(),
                CustomText(trackingCode.length>16?'شماره شاسی :':'کد رهگیری:',
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    isRtl: true),
              ],
            ),
            const SizedBox(height: 4),
            Center(
                child: CustomText(trackingCode,
                    isRtl: true,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold)),
            const Divider(),
            CustomText('خودرو:',
                isRtl: true,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(carName,
                    isRtl: true,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
                Container(
                  color: AppColors.lightGrey,
                  height: 20,
                  width: 2,
                ),
                CustomText(carModel,
                    isRtl: true,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
                Container(
                  color: AppColors.lightGrey,
                  height: 20,
                  width: 2,
                ),
                CustomText(carEngine,
                    isRtl: true,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
                Container(
                  color: AppColors.lightGrey,
                  height: 20,
                  width: 2,
                ),
                CustomText(carColor,
                    isRtl: true,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
                Container(
                  color: AppColors.lightGrey,
                  height: 20,
                  width: 2,
                ),
                CustomText(carYear,
                    isRtl: true,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
