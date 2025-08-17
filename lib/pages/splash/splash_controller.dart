import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/outlined_button.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/storage_helper.dart';
import 'package:sigma/helper/variant_manager.dart';
import 'package:sigma/models/global_app_data.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

import '../../helper/helper.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;
  var isVideoReady = false.obs;
  var showUpdateDialog = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeVideo();
    getInfo();
  }

  void _videoListener() {
    if (videoController.value.position >= videoController.value.duration) {}
  }

  Future<void> _initializeVideo() async {
    try {
      videoController = VideoPlayerController.asset('assets/motion.mp4');
      await videoController.initialize();
      videoController.setLooping(false);
      videoController.setVolume(0.0); // Mute for splash

      isVideoReady.value = true;
      videoController.play();

      // Listen for video completion
      videoController.addListener(_videoListener);
    } catch (e) {
      print('Video initialization error: $e');
      // Fallback: navigate after delay if video fails
      Future.delayed(Duration(seconds: 3), () {});
    }
  }

  Future<void> getInfo() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLogedIn = await StorageHelper().getIsLogedIn() ?? false;

    // Check for updates first
    if (!kIsWeb) {
      await _checkForUpdates();
    }
    var response = await DioClient.instance.getBanners();
    if (response != null && response.message == 'OK') {
      GlobalAppData().setPelaksefid(response?.pelakSefidLink ?? "");
      GlobalAppData().setInsta(response?.instaLink ?? "");
      GlobalAppData().aparat = (response?.aparatLink ?? "");
      GlobalAppData().linkedin = (response?.linkedinLink ?? "");
      GlobalAppData().telegram = (response?.telegramLink ?? "");
    }

    // Only navigate if no update dialog is shown
    if (!showUpdateDialog.value) {
      if (isLogedIn) {
        Get.offAllNamed(RouteName.home);
      } else {
        Get.offAllNamed(RouteName.auth);
      }
    }
  }

  Future<void> _checkForUpdates() async {
    print('check version called');
    try {
      // Get current version
      String currentVersion = '';


      currentVersion = await getVersion();
      // Call your API to check for updates (replace with your actual API call)
      var verResponse = await DioClient.instance.checkVersion();
      print((verResponse?.newVersion ?? "") );
      print(currentVersion);
      if (verResponse != null && verResponse.status == 0) {
        if (verResponse.forceUpdate == '1') {
          _showForceUpdateDialog(verResponse.updateLink ?? '');
        } else if (verResponse.newVersion != currentVersion) {
          _showOptionalUpdateDialog(verResponse.updateLink ?? '');
        }
      }
    } catch (e) {
      print('Error checking for updates: $e');
    }
  }

  void _showForceUpdateDialog(String updateUrl) {
    showUpdateDialog.value = true;
    Get.dialog(
      AlertDialog(
        //  title: Text('بروزرسانی اجباری'),
        content: CustomText(
            'نسخه جدید با تجربه کاربری بهتر آماده است. \nلطفا همین حالا بروزرسانی کنید.',
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            isRtl: true,
            size: 14,
            color: Colors.black),
        actions: [
          Row(
            children: [
              Expanded(
                child: customOutlinedButton(() {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0); // Not recommended for App Store apps
                  }
                }, 'بازگشت',
                    txtColor: Colors.black, borderColorolor: Colors.black),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ConfirmButton(
                  () => _openAppInStore(updateUrl),
                  'به روز رسانی',
                ),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _showOptionalUpdateDialog(String updateUrl) {
    showUpdateDialog.value = true;
    Get.dialog(
      AlertDialog(
        content: CustomText(
            'نسخه جدید با تجربه کاربری بهتر آماده است. \nلطفا همین حالا بروزرسانی کنید.',
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            size: 14,
            isRtl: true,
            color: Colors.black),
        actions: [
          Row(
            children: [
              Expanded(
                child: customOutlinedButton(() {
                  Get.back();
                  showUpdateDialog.value = false;
                  _continueWithNavigation();
                }, 'ادامه',
                    borderColorolor: Colors.black, txtColor: Colors.black),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ConfirmButton(
                  () => _openAppInStore(updateUrl),
                  'به روز رسانی',
                ),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  void _continueWithNavigation() async {
    bool isLogedIn = await StorageHelper().getIsLogedIn() ?? false;
    if (isLogedIn) {
      Get.offAllNamed(RouteName.home);
    } else {
      Get.offAllNamed(RouteName.auth);
    }
  }

  Future<void> _openAppInStore(String updateUrl) async {
    // استفاده از BuildVariantStoreManager
    await BuildVariantStoreManager.openAppInStore(updateUrl);
  }

  @override
  void onClose() {
    videoController.removeListener(_videoListener);
    videoController.dispose();
    super.onClose();
  }
}
