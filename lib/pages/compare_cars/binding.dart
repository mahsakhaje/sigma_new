import 'package:get/get.dart';
import 'package:sigma/pages/compare_cars/compare_cars_controller.dart';

class CompareCarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompareCarsController>(() => CompareCarsController());
  }
}