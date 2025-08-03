import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/storage_helper.dart';
import 'package:sigma/models/global_app_data.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;
  var isVideoReady = false.obs;

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
    var response = await DioClient.instance.getBanners();
    if (response != null && response.message == 'OK') {
      GlobalAppData().setPelaksefid(response?.pelakSefidLink ?? "");
      GlobalAppData().setInsta(response?.instaLink ?? "");
      GlobalAppData().aparat = (response?.aparatLink ?? "");
      GlobalAppData().linkedin = (response?.linkedinLink ?? "");
      GlobalAppData().telegram = (response?.telegramLink ?? "");
    }
    if (isLogedIn) {
      Get.offAllNamed(RouteName.home);
    } else {
      Get.offAllNamed(RouteName.auth);
    }
  }
}
