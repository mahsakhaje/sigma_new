import 'package:get/get.dart';

class AppDataController extends GetxController{



  var geoProvinces = <String, String>{}.obs;

  var geoCityNames = <String, String>{}.obs;

  void setProvinces(Map<String, String> newProvinces) {
    geoProvinces.value = newProvinces;
  }

  void setCities(Map<String, String> newCities) {
    geoCityNames.value = newCities;
  }

  Map<String, String>? getProvinces() => geoProvinces;
  Map<String, String>? getCityName() => geoCityNames;


}