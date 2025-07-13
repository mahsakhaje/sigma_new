import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:sigma/models/application_info_model.dart';
import 'storage_keys.dart';

class StorageHelper {
  // Private static instance variable
  static final StorageHelper _instance = StorageHelper._internal();

  // Private constructor
  StorageHelper._internal() {
    // Initialize any setup here if needed
  }

  // Public factory constructor to return the single instance
  factory StorageHelper() {
    return _instance;
  }

  final box = GetStorage();

  bool? getSeenPreLogin() => box.read(SeenPreLogin);

  void setSeenPreLogin(bool isSeen) => box.write(SeenPreLogin, isSeen);

  bool? getIsLogedIn() => box.read(ISLOGEDIN);

  void setIsLogedIn(bool isLoggedIn) => box.write(ISLOGEDIN, isLoggedIn);

  bool? getHasSeenIntro() => box.read(HASSEENINTRO);

  void setHasSeednIntro(bool hasSeen) => box.write(HASSEENINTRO, hasSeen);

  String? getPhoneNumber() => box.read(phoneNumberKey);

  void setPhoneNumber(String phoneNumber) => box.write(phoneNumberKey, phoneNumber);

  String? getShortToken() => box.read(SHORTTOKENKEY);

  void setShortToken(String token) => box.write(SHORTTOKENKEY, token);

  String? getName() => box.read(NameKEY);

  void setName(String name) => box.write(NameKEY, name);

  bool? getSeenGuide() => box.read(ISSEENGUIDE);

  void setSeenGuide(bool seen) => box.write(ISSEENGUIDE, seen);

  String? getToken() => box.read(TokenKEY);

  void setToken(String token) => box.write(TokenKEY, token);

  String? getOrderId() => box.read(OrderKey);

  void setOrderId(String orderId) => box.write(OrderKey, orderId);

  bool? getHasSeenBanner() => box.read(hasSeenBannerKey);

  void setHasSeenBanner(bool seen) => box.write(hasSeenBannerKey, seen);

  List<Infos>? getBanner() {
    List<String>? jsonList = box.read(BannerKey)?.cast<String>();
    if (jsonList == null) return null;
    return jsonList.map((jsonString) => Infos.fromJson(json.decode(jsonString))).toList();
  }

  void setBanner(List<Infos> banners) {
    List<String> jsonList = banners.map((infos) => json.encode(infos.toJson())).toList();
    box.write(BannerKey, jsonList);
  }
}