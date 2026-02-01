import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/contact_us/contact_us_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({super.key});

  final ContactUsController controller = Get.put(ContactUsController());

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    print(phoneNumber);
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    await _launchUrl('tel:$cleanNumber');
  }

  Future<void> _sendEmail(String email) async {
    try {
      final cleanEmail = email.trim();
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: cleanEmail,
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      } else {
        // اگر برنامه ایمیل وجود نداشت، کپی کردن ایمیل در کلیپ‌بورد
        await Clipboard.setData(ClipboardData(text: cleanEmail));
      showToast(
          ToastState.INFO,
          'ایمیل کپی شد: $cleanEmail',

        );
      }
    } catch (e) {
      // fallback: کپی ایمیل
      await Clipboard.setData(ClipboardData(text: email));
      showToast(
        ToastState.INFO,
        'ایمیل کپی شد: $email',

      );
    }
  }



  String _extractEmail(String? text) {
    if (text == null || text.isEmpty) return '';

    final emailRegex =
        RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');

    final match = emailRegex.firstMatch(text);
    return match?.group(0) ?? text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  rowItem(
                      'آدرس',
                      (controller.address.value ?? '') +
                          '\n' +
                          (controller.showRoomAddress.value ?? ''),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                      isAddress: true),

                  rowItemWithPhone(
                      'واحد فروش و عملیات',
                      controller.telephone.value,
                      Icon(Icons.local_offer_outlined,
                          color: Colors.white, size: 26)),
                  rowItemWithPhone(
                      'پشتیبانی نرم افزار',
                      controller.supportTelephone.value,
                      Icon(Icons.support_agent_outlined,
                          color: Colors.white, size: 26)),
                  rowItemWithEmail(
                      'ایمیل',
                      controller.email.value,
                      Icon(Icons.alternate_email_outlined,
                          color: Colors.white, size: 26)),
                  rowItemWithPhone(
                      'کرمان موتور',
                      controller.suggestionNumber.value,
                      Icon(Icons.person_search_outlined,
                          color: Colors.white, size: 26))
                ],
              ),
            )),
        title: Strings.contactus);
  }

  Widget rowItem(String? title, String? value, Widget icon,
      {bool isAddress = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(title ?? '', fontWeight: FontWeight.bold, size: 15),
              SizedBox(width: 4),
              icon
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: CustomText(value?.trim() ?? '',
                      size: 14, maxLine: 20, isRtl: true)),
              SizedBox(width: 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget rowItemWithPhone(String? title, String? value, Widget icon) {
    final phoneNumbers = extractPhoneNumbers(value);
    print(phoneNumbers);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(title ?? '', fontWeight: FontWeight.bold, size: 15),
              SizedBox(width: 4),
              icon
            ],
          ),
          SizedBox(height: 8),
          if (phoneNumbers.isEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                    child: CustomText(value?.trim() ?? '',
                        size: 14, maxLine: 20, isRtl: true)),
                SizedBox(width: 4),
              ],
            )
          else
            ...phoneNumbers.map((phone) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () => _makePhoneCall(phone),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 8),
                              CustomText(
                                phone,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }

  Widget rowItemWithEmail(String? title, String? value, Widget icon) {
    final email = _extractEmail(value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(title ?? '', fontWeight: FontWeight.bold, size: 15),
              SizedBox(width: 4),
              icon
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: InkWell(
                  onTap: () => _sendEmail(email),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 8),
                      CustomText(
                        email,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
            ],
          ),
        ],
      ),
    );
  }
}
