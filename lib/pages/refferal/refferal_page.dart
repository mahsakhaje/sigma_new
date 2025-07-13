import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/refferal/refferal_controller.dart'
    show ReferralController;

class ReferralPage extends StatelessWidget {
  ReferralPage({Key? key}) : super(key: key);
  final ReferralController controller = Get.put(ReferralController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: Strings.referral,
      child: Obx(() => controller.isLoading.value
          ?  Center(
              child: loading(),
            )
          : _buildContent()),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.containerBg,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/happy.svg'),
                SizedBox(
                  height: 12,
                ),
                _buildInstructionCard(),
                const SizedBox(height: 84),
                _buildReferralCodeContainer(),
              ],
            ),
          ),
          const SizedBox(height: 26),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildInstructionCard() {
    return CustomText(
      Strings.sendReferral,
      fontWeight: FontWeight.bold,
      size: 16,
      isRtl: true,
      textAlign: TextAlign.center
    );
  }

  Widget _buildReferralCodeContainer() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _copyReferralCode(),
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.copy_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                Obx(() => CustomText(
                    'کد دعوت :  ${controller.referralCode.value}',
                    size: 16,isRtl: true)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return ConfirmButton(
      () => Share.share(controller.referralLink.value),
      Strings.sendReferralToFriends,
    );
  }

  Future<void> _copyReferralCode() async {
    try {
      await Clipboard.setData(
          ClipboardData(text: controller.referralCode.value));
      showToast(ToastState.SUCCESS, 'با موفقیت کپی شد');
    } catch (e) {
      showToast(ToastState.ERROR, 'کپی با خطا مواجه شد');
    }
  }
}
