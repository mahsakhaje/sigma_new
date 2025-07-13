import 'package:get/get.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/rules_model.dart';

class PdfController extends GetxController {
  // Observable variables
  final Rx<RulesResponse?> _response = Rx<RulesResponse?>(null);
  final RxBool _isLoading = true.obs;

  // Getters
  RulesResponse? get response => _response.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _loadRules();
  }

  Future<void> _loadRules() async {
    try {
      _isLoading.value = true;
      final result = await DioClient.instance.getRules();
      _response.value = result;
    } catch (e) {
      // Handle error - you can add error handling here
      print('Error loading rules: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  // Method to refresh data if needed
  Future<void> refreshRules() async {
    await _loadRules();
  }
}