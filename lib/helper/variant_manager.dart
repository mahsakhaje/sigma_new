import 'dart:io';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BuildVariantStoreManager {
  static const String CAFEBAZAAR_PACKAGE = "com.farsitel.bazaar";
  static const String MYKET_PACKAGE = "ir.mservices.market";
  static const MethodChannel _channel = MethodChannel('app_installer_channel');

  // تشخیص build variant از طریق package name یا application ID
  static Future<String> _getBuildVariant() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;

      // بر اساس package name تشخیص variant
      if (packageName.contains('.cafebazaar') ||
          packageName.contains('.bazaar')) {
        return 'cafebazaar';
      } else if (packageName.contains('.myket')) {
        return 'myket';
      } else if (packageName.contains('.googleplay') ||
          packageName.contains('.playstore')) {
        return 'googleplay';
      } else {
        // پیش‌فرض: تشخیص از installer
        return await _detectFromInstaller(packageName) ?? 'cafebazaar';
      }
    } catch (e) {
      print('Error detecting build variant: $e');
      return 'cafebazaar'; // پیش‌فرض
    }
  }

  static Future<String?> _detectFromInstaller(String packageName) async {
    try {
      String? installer =
          await _channel.invokeMethod('getInstallerPackageName', {
        'packageName': packageName,
      });

      switch (installer) {
        case CAFEBAZAAR_PACKAGE:
          return 'cafebazaar';
        case MYKET_PACKAGE:
          return 'myket';
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  // متد اصلی برای باز کردن فروشگاه بر اساس build variant
  static Future<void> openAppInStore([String? customUpdateUrl]) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;

      if (Platform.isIOS) {
        // Open App Store for iOS
        String appStoreUrl =
            'https://sibapp.com/applications/sigma'; // Replace with your actual App Store ID
        await launchUrl(Uri.parse(appStoreUrl));
        return;
      }

      String buildVariant = await _getBuildVariant();

      // اگر لینک سفارشی ارائه شده و از سایت شما است
      if (customUpdateUrl != null && customUpdateUrl.contains('sigmatec.ir')) {
        await _launchUrl(customUpdateUrl);
        return;
      }

      // بر اساس build variant عمل کن
      switch (buildVariant) {
        case 'cafebazaar':
          await _openCafeBazaar(packageName);
          break;
        case 'myket':
          await _openMyket(packageName);
          break;
        case 'googleplay':
          await _openGooglePlay(packageName);
          break;
        default:
          await _openCafeBazaar(packageName); // پیش‌فرض
      }
    } catch (e) {
      print('Error opening app store: $e');
      // در صورت خطا، کافه بازار را باز کن
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      await _openCafeBazaar(packageInfo.packageName);
    }
  }

  static Future<void> _openCafeBazaar(String packageName) async {
    final Uri bazaarUri = Uri.parse('bazaar://details?id=$packageName');
    final Uri bazaarWebUri =
        Uri.parse('https://cafebazaar.ir/app/$packageName');

    try {
      if (await canLaunchUrl(bazaarUri)) {
        await launchUrl(bazaarUri);
      } else {
        await launchUrl(bazaarWebUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Error opening Cafe Bazaar: $e');
    }
  }

  static Future<void> _openMyket(String packageName) async {
    final Uri myketUri = Uri.parse('myket://comment?id=$packageName');
    final Uri myketWebUri = Uri.parse('https://myket.ir/app/$packageName');

    try {
      if (await canLaunchUrl(myketUri)) {
        await launchUrl(myketUri);
      } else {
        await launchUrl(myketWebUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Error opening Myket: $e');
    }
  }

  static Future<void> _openGooglePlay(String packageName) async {
    final Uri playStoreUri = Uri.parse('market://details?id=$packageName');
    final Uri playStoreWebUri =
        Uri.parse('https://play.google.com/store/apps/details?id=$packageName');

    try {
      if (await canLaunchUrl(playStoreUri)) {
        await launchUrl(playStoreUri);
      } else {
        await launchUrl(playStoreWebUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Error opening Google Play: $e');
    }
  }

  static Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  // تشخیص نام فروشگاه برای نمایش در UI
  static Future<String> getStoreName() async {
    String variant = await _getBuildVariant();
    switch (variant) {
      case 'cafebazaar':
        return 'کافه بازار';
      case 'myket':
        return 'مایکت';
      case 'googleplay':
        return 'گوگل پلی';
      default:
        return 'فروشگاه';
    }
  }

  // دریافت لینک مستقیم فروشگاه
  static Future<String> getStoreWebLink() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    String variant = await _getBuildVariant();

    switch (variant) {
      case 'cafebazaar':
        return 'https://cafebazaar.ir/app/$packageName';
      case 'myket':
        return 'https://myket.ir/app/$packageName';
      case 'googleplay':
        return 'https://play.google.com/store/apps/details?id=$packageName';
      default:
        return 'https://cafebazaar.ir/app/$packageName';
    }
  }
}
