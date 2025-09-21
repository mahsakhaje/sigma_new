import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:universal_platform/universal_platform.dart';

void showToast(ToastState state, String msg, {bool isIos = false}) {
//popup a attachments toast

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      fontAsset: 'fonts/Peyda-Medium.ttf',
      backgroundColor: state == ToastState.ERROR
          ? Colors.red
          : state == ToastState.SUCCESS
              ? Colors.green
              : state == ToastState.INFO
                  ? AppColors.orange
                  : Colors.blueGrey,
      gravity: ToastGravity.BOTTOM,
      webBgColor: state == ToastState.ERROR
          ? "linear-gradient(to right, #dc1c13, #dc1c13)"
          : state == ToastState.SUCCESS
              ? "linear-gradient(to right, #40d12a, #40d12a)"
              : state == ToastState.INFO
                  ? "linear-gradient(to right, #c5c8c9, #c5c8c9)"
                  : Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 14);
  return;

  var cancel = BotToast.showAttachedWidget(
      preferDirection: PreferDirection.bottomCenter,
      attachedBuilder: (_) => Card(
            color: state == ToastState.ERROR
                ? Colors.red.shade400
                : state == ToastState.SUCCESS
                    ? Colors.green
                    : state == ToastState.INFO
                        ? Colors.grey
                        : Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/sigmapng.png',
                    width: 40,
                    height: 40,
                  ),
                  CustomText(msg,
                      color: Colors.white, isRtl: true, maxLine: 3, size: 12),
                  SizedBox(
                    width: 4,
                  )
                ],
              ),
            ),
          ),
      duration: Duration(seconds: 2),
      target: Offset(520, 520));
}

enum ToastState { ERROR, INFO, SUCCESS }

Image imageFromBase64String(String base64String, double height,
    {double? width}) {
  return Image.memory(
    base64Decode(base64String),
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}

Future<bool> isVpnActive() async {
  return false;
  //bool isVpnActive;
  // if (kIsWeb) {
  //   return false;
  // }
  // List<NetworkInterface> interfaces = await NetworkInterface.list(
  //     includeLoopback: false, type: InternetAddressType.any);
  // interfaces.isNotEmpty
  //     ? isVpnActive = interfaces.any((interface) =>
  //         interface.name.contains("tun") ||
  //         interface.name.contains("ppp") ||
  //         interface.name.contains("pptp"))
  //     : isVpnActive = false;
  // return isVpnActive;
}



Future<bool> hasConnection() async {
  bool connected = await NetworkChecker.hasInternetConnection();

  if (!connected) {
    return false;
  } else {
    return true;
  }
}
// Widget DarkBackgroundWidget({required Widget child}) {
//   return Container(
//       decoration: new BoxDecoration(gradient: getBgGradient()), child: child);
// }

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class NumberUtils {
  static double clamp(double x, double min, double max) {
    if (x < min) x = min;
    if (x > max) x = max;

    return x;
  }

  static final numberFormat = NumberFormat('###,###,###,###', 'en_US');

  static String separateThousand(num amount) {
    return numberFormat.format(amount);
  }

  static String lrm = '\u200E';
  static String rlm = '\u200F';

  static String toTomans(num amount, {bool devide = true}) {
    if (devide) {
      amount = amount / 10;
    }

    final a = numberFormat.format(amount);
    return '$rlm$a تومان'.usePersianNumbers();
  }

  static double applyPercent(num price, int salePercent) {
    return double.parse((price * (10 - (salePercent / 100)) / 10).toString());
  }
}

extension Helper on String {
  bool isOk() {
    if (this == 'ok') {
      return true;
    }
    return false;
  }

  String usePersianNumbers() {
    if (this.isEmpty) {
      return this;
    }

    var x = this;
    x = x.replaceAll('0', '\u06F0');
    x = x.replaceAll('1', '\u06F1');
    x = x.replaceAll('2', '\u06F2');
    x = x.replaceAll('3', '\u06F3');
    x = x.replaceAll('4', '\u06F4');
    x = x.replaceAll('5', '\u06F5');
    x = x.replaceAll('6', '\u06F6');
    x = x.replaceAll('7', '\u06F7');
    x = x.replaceAll('8', '\u06F8');
    x = x.replaceAll('9', '\u06F9');

    x = x.replaceAll('\u0660', '\u06F0');
    x = x.replaceAll('\u0661', '\u06F1');
    x = x.replaceAll('\u0662', '\u06F2');
    x = x.replaceAll('\u0663', '\u06F3');
    x = x.replaceAll('\u0664', '\u06F4');
    x = x.replaceAll('\u0665', '\u06F5');
    x = x.replaceAll('\u0666', '\u06F6');
    x = x.replaceAll('\u0667', '\u06F7');
    x = x.replaceAll('\u0668', '\u06F8');
    x = x.replaceAll('\u0669', '\u06F9');

    return x;
  }
}

List<TextInputFormatter> digitsOnly() {
  return [FilteringTextInputFormatter.digitsOnly];
}

void _hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
  FocusScope.of(context).requestFocus(FocusNode());
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  //WidgetsBinding.instance.focusManager.backgroundColorFocus?.unfocus();
}

void hideKeyboard(BuildContext context) {
  _hideKeyboard(context);

  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    _hideKeyboard(context);
  });
}

final _numberFormat = NumberFormat('###,###,###,###', 'en_US');

String separateThousand(int amount) {
  return _numberFormat.format(amount);
}

class PersianLettersFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Filter to only allow Persian letters and space
    String filteredText = newValue.text.replaceAll(RegExp(r'[^آ-ی\s]'), '');

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

// Alternative version with more complete Persian character support
class PersianLettersFormatterExtended extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // More comprehensive Persian character range including additional characters
    String filteredText = newValue.text.replaceAll(
        RegExp(r'[^ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیئءآأإؤة\s]'), '');

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class PersianFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // First, filter to only allow digits (both English and Persian)
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9۰-۹]'), '');

    if (filteredText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Convert English digits to Persian
    String convertedText = englishToPersian(filteredText);

    return newValue.copyWith(
      text: convertedText,
      selection: TextSelection.collapsed(offset: convertedText.length),
    );
  }
}

String englishToPersian(String text) {
  RegExp englishNumberRegex = RegExp(r'[0-9]');

  String convertedText = text.replaceAllMapped(englishNumberRegex, (match) {
    int persianCodePoint = (match.group(0)?.codeUnitAt(0) ?? 0) + 1728;
    return String.fromCharCode(persianCodePoint);
  });

  return convertedText;
}

class EnglishFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newEng = persianToEnglish(newValue.text);
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else {
      return newValue.copyWith(text: newEng);
    }
  }
}

String persianToEnglish(String persianText) {
  // Regular expression to match Persian and Arabic-Indic numbers
  RegExp persianNumberRegex = RegExp(r'[\u06F0-\u06F9]');
  RegExp arabicIndicNumberRegex = RegExp(r'[\u0660-\u0669]');

  // Function to convert matched Persian number to English number
  String replacePersianNumbers(Match match) {
    int englishCodePoint = (match.group(0)?.codeUnitAt(0) ?? 0) - 1728;
    return String.fromCharCode(englishCodePoint);
  }

  // Function to convert matched Arabic-Indic number to English number
  String replaceArabicIndicNumbers(Match match) {
    int englishCodePoint = (match.group(0)?.codeUnitAt(0) ?? 0) - 1584;
    return String.fromCharCode(englishCodePoint);
  }

  // Replace Persian and Arabic-Indic numbers in the text
  String result =
      persianText.replaceAllMapped(persianNumberRegex, replacePersianNumbers);
  result = result.replaceAllMapped(
      arabicIndicNumberRegex, replaceArabicIndicNumbers);

  return result;
}

// Future<void> checkLogin(BuildContext context) async {
//   bool isLogIn = await SharedPreferencesHelper().getIsLogedIn() ?? false;
//   if (isLogIn) {
//     return;
//   } else {
//     navigateToScreen(context, login, replace: true);
//   }
// }

double cardBorderRadius() => 8;

// Future<void> logOut(BuildContext context) async {
//   bool? shouldLogOut = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CustomText('آیا مایل به خروج از حساب کاربری خود هستید؟',
//                 color: Colors.black87, isRtl: true, size: 15),
//             SizedBox(
//               height: 34,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: CustomOutlinedButton(() {
//                       Navigator.of(context).pop(false);
//                     }, 'انصراف',
//                         txtColor: Colors.black87,
//                         borderColorolor: Colors.red),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 4,
//                 ),
//                 Expanded(
//                   child: ConfirmButton(
//                         () async {
//                       Navigator.of(context).pop(true);
//                     },
//                     'تایید',
//                     borderRadius: 8,
//                     fontSize: 12,
//                     color: blue,
//                     txtColor: Colors.white,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ));
//   if (shouldLogOut ?? false) {
//     await SharedPreferencesHelper().setIsLogedIn(false);
//     await SharedPreferencesHelper().setPhoneNumber('');
//     await SharedPreferencesHelper().setShortToken('');
//     Navigator.of(context).pop();
//     navigateToScreen(context, login, replace: true);
//     if (!kIsWeb) {
//       await FirebaseAnalytics.instance.logEvent(name: logOut_key);
//     }
//   }
// }

Future<String> getVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();
  var version = '';
  version = packageInfo.version;
  String cleanVersion = version.split('-')[0].split('+')[0];
  version = cleanVersion;
  if (UniversalPlatform.isAndroid) {
    version = 'a$version';
  }
  if (UniversalPlatform.isIOS) {
    version = 'i$version';
  }
  return version;
}

Future<String> saveFile(String fileName, List<int> bytes) async {
  try {
    Directory directory;

    if (defaultTargetPlatform == TargetPlatform.android) {
      // Try to get Downloads directory first
      try {
        final List<Directory>? downloadsDir =
            await getExternalStorageDirectories(
                type: StorageDirectory.downloads);
        if (downloadsDir != null && downloadsDir.isNotEmpty) {
          directory = downloadsDir.first;
        } else {
          // Fallback to external storage
          directory = await getExternalStorageDirectory() ??
              await getApplicationDocumentsDirectory();
          // Create Downloads subfolder
          directory = Directory('${directory.path}/Download');
        }
      } catch (e) {
        print('Error accessing Downloads: $e');
        directory = await getApplicationDocumentsDirectory();
      }
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    // Ensure directory exists
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // Clean filename to avoid path issues
    final cleanFileName = fileName.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
    final filePath =
        '${directory.path}${Platform.pathSeparator}$cleanFileName.pdf';

    print('Saving to: $filePath');

    final file = File(filePath);

    // Write file
    await file.writeAsBytes(bytes);

    // Verify file was created and has content
    if (await file.exists() && await file.length() > 0) {
      print('File saved successfully: $filePath');
      showToast(ToastState.SUCCESS, 'با موفقیت ذخیره شد');
      return filePath; // Return full file path, not just directory
    } else {
      throw Exception('File was not created properly');
    }
  } on FileSystemException catch (e) {
    print('FileSystemException: ${e.message}');
    showToast(ToastState.ERROR, 'خطا در ذخیره فایل');
    throw Exception('Failed to save file: ${e.message}');
  } catch (e) {
    print('Unexpected error: $e');
    showToast(ToastState.ERROR, 'خطای غیرمنتظره');
    rethrow;
  }
}

// Alternative method for Android Downloads folder
Future<String> saveFileToDownloads(String fileName, List<int> bytes) async {
  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Get Android SDK version
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      // Request appropriate permissions based on Android version
      if (sdkInt >= 33) {
        // Android 13+ (API 33+) - Request photos permission for media files
        var status = await Permission.photos.status;
        if (!status.isGranted) {
          status = await Permission.photos.request();
          if (!status.isGranted) {
            print('Photos permission denied, trying without permission...');
          }
        }
      } else if (sdkInt >= 30) {
        // Android 11+ (API 30+) - Request manage external storage
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          status = await Permission.manageExternalStorage.request();
          if (!status.isGranted) {
            print('Manage external storage permission denied, trying limited access...');
          }
        }
      } else {
        // Android 10 and below - Use legacy storage permission
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
          if (!status.isGranted) {
            throw Exception('Storage permission denied');
          }
        }
      }

      // Try multiple approaches to get Downloads directory
      Directory? directory;

      // Method 1: Try using getExternalStorageDirectory
      try {
        final externalDir = await getExternalStorageDirectory();
        if (externalDir != null) {
          directory = Directory('${externalDir.parent.parent.parent.parent.path}/Download');
        }
      } catch (e) {
        print('Method 1 failed: $e');
      }

      // Method 2: Direct path (fallback)
      if (directory == null || !await directory.exists()) {
        directory = Directory('/storage/emulated/0/Download');
      }

      // Method 3: Alternative direct path
      if (!await directory.exists()) {
        directory = Directory('/sdcard/Download');
      }

      // Create directory if it doesn't exist
      if (!await directory.exists()) {
        try {
          await directory.create(recursive: true);
        } catch (e) {
          print('Failed to create directory: $e');
          throw Exception('Cannot create Downloads directory');
        }
      }

      print('Using directory: ${directory.path}');

      // Clean filename and create file
      final cleanFileName = fileName.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
      final filePath = '${directory.path}/$cleanFileName.pdf';

      final file = File(filePath);

      // Write file with error handling
      try {
        await file.writeAsBytes(bytes);

        // Verify file was written successfully
        if (await file.exists() && await file.length() > 0) {
          print('File successfully saved to: $filePath');
          showToast(ToastState.SUCCESS, 'فایل در پوشه دانلود ذخیره شد');
          return filePath;
        } else {
          throw Exception('File not created or is empty');
        }
      } catch (e) {
        print('Error writing file: $e');
        throw Exception('Failed to write file: $e');
      }
    }

    // Fallback for other platforms
    return await saveFile(fileName, bytes);
  } catch (e) {
    print('Error saving to Downloads: $e');
    // Fallback to app directory
    return await saveFile(fileName, bytes);
  }
}
class NetworkChecker {
  /// Checks both connectivity and actual internet access
  static Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false; // No network at all
    }

    // Check actual internet access by pinging a reliable server
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }

    return false;
  }
}