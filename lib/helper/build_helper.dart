import 'package:flutter/services.dart';

class BuildConfigHelper {
  static const MethodChannel _channel = MethodChannel('build_config_channel');

  static String? _storeType;
  static String? _storeName;
  static String? _storePackage;

  // دریافت نوع فروشگاه از Native
  static Future<String> getStoreType() async {
    if (_storeType != null) return _storeType!;

    try {
      _storeType = await _channel.invokeMethod('getStoreType');
      return _storeType ?? 'auto';
    } catch (e) {
      print('Error getting store type: $e');
      return 'auto';
    }
  }

  // دریافت نام فروشگاه از Native
  static Future<String> getStoreName() async {
    if (_storeName != null) return _storeName!;

    try {
      _storeName = await _channel.invokeMethod('getStoreName');
      return _storeName ?? 'فروشگاه';
    } catch (e) {
      print('Error getting store name: $e');
      return 'فروشگاه';
    }
  }

  // دریافت package فروشگاه از Native
  static Future<String> getStorePackage() async {
    if (_storePackage != null) return _storePackage!;

    try {
      _storePackage = await _channel.invokeMethod('getStorePackage');
      return _storePackage ?? '';
    } catch (e) {
      print('Error getting store package: $e');
      return '';
    }
  }

  // بررسی اینکه آیا build از فروشگاه خاصی است
  static Future<bool> isFromStore(String storeType) async {
    String currentStore = await getStoreType();
    return currentStore == storeType;
  }

  // دریافت تمام اطلاعات build config
  static Future<Map<String, String>> getAllBuildInfo() async {
    return {
      'storeType': await getStoreType(),
      'storeName': await getStoreName(),
      'storePackage': await getStorePackage(),
    };
  }
}