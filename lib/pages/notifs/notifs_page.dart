import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/badge.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/notifs/notifs_controller.dart';

class NotifsListPage extends StatelessWidget {
  NotifsListPage({super.key});

  NotifController controller = Get.put(NotifController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(

        child: Obx(() => _buildBody()), title: 'پیام ها');
  }

  _buildBody() {
    if (controller.isLoading.value) {
      return Center(
        child: loading(),
      );
    } else {
      if (controller.hasError.value) {
        return Center(child: CustomText('خطا در دریافت اطلاعات'));
      } else {
        return Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                badge(
                    ' شما ${controller.unreadCount.value} پیام خوانده نشده دارید.'
                        .usePersianNumbers()),
                SizedBox(
                  width: 12,
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: controller.accountNotifs.length,
                  itemBuilder: (ctx, index) {
                    return buildNotifListItem(index);
                  }),
            ),
          ],
        );
      }
    }
  }

  Container buildNotifListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: index < controller.unreadCount.value
                  ? AppColors.orange
                  : Colors.white),
          color: index < controller.unreadCount.value
              ? Colors.grey.shade300
              : Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomText(
              (controller.accountNotifs[index].description ?? "")
                  .usePersianNumbers(),
              color: AppColors.darkGrey,
              fontWeight: FontWeight.bold,isRtl: true),
          SizedBox(height: 8,),
          CustomText(
              (controller.accountNotifs[index].registerDate ?? "")
                  .usePersianNumbers(),
              color: AppColors.darkGrey,
              fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
}
