import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/pages/splash/splash_controller.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Obx(() => controller.hasInternet.value
            ? controller.isVideoReady.value
                ? GestureDetector(
                    child: AspectRatio(
                      aspectRatio: 0.6,
                      child: VideoPlayer(controller.videoController),
                    ),
                  )
                : _buildLoadingWidget()
            : _buildNoInternet()),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/sigma.svg'),
      ],
    );
  }

  Widget _buildNoInternet() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText('دسترسی به اینترنت وجود ندارد.',
              isRtl: true, size: 16, textAlign: TextAlign.justify),
          CustomText(' لطفا پس از بررسی مشکل مجددا تلاش کنید.',
              isRtl: true, size: 16, textAlign: TextAlign.justify),
          SizedBox(height: 40,),
          SvgPicture.asset('assets/plug.svg'),
          SizedBox(height: 20,),
          SizedBox(
            height: 16,
          ),
          controller.loading.value
              ? loading()
              : ConfirmButton(() => controller.checkInternet(), 'تلاش مجدد')
        ],
      ),
    );
  }
}
