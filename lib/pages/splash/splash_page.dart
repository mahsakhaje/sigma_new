import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/pages/splash/splash_controller.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Obx(() => controller.isVideoReady.value
            ? GestureDetector(
          child: AspectRatio(
            aspectRatio: 0.6,
            child: VideoPlayer(controller.videoController),
          ),
        )
            : _buildLoadingWidget()),
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
}