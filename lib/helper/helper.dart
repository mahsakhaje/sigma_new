import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:universal_platform/universal_platform.dart';

void showToast(ToastState state, String msg, {bool isIos = false}) {
//popup a attachments toast

    Fluttertoast.showToast(
        msg: msg,

        toastLength: Toast.LENGTH_LONG,

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

    fontSize: 14
    );
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
        RegExp(r'[^ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیئءآأإؤة\s]'),
        ''
    );

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
  final _packageInfo = await PackageInfo.fromPlatform();
  var version = await _packageInfo.version;

  if (UniversalPlatform.isAndroid) {
    version = 'a$version';
  }
  if (UniversalPlatform.isIOS) {
    version = 'i$version';
  }
  return version ?? "";
}

Future<String> saveFile(String fileName, List<int> bytes) async {
  showToast(ToastState.INFO, 'لطفا منتظر بمانید');

  Directory? directory;
  File? file;
  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
//downloads folder - android only - API>30
      directory = Directory('/storage/emulated/0/Download');
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    bool hasExisted = await directory.exists();
    if (!hasExisted) {
      directory.create();
    }

//file to saved
    file = File("${directory.path}${Platform.pathSeparator}$fileName.pdf");
    if (!file.existsSync()) {
      await file.create();
    }
    await file.writeAsBytes(bytes);
    showToast(ToastState.SUCCESS, 'با موفقیت ذخیره شد');
    return directory.path;
  } catch (e) {

    if (file != null && file.existsSync()) {
      file.deleteSync();
    }
    rethrow;
  }
}
