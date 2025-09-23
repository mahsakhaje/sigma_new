import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/auth/auth_controller.dart';
import 'package:sms_autofill/sms_autofill.dart';

class CustomPinput extends StatelessWidget {
  final void Function(String)? onCompleted;

  final String? Function(String?)? validator;
  TextEditingController textController;
  String code;

  CustomPinput(
      {Key? key,
      this.onCompleted,
      this.validator,
      required this.code,
      required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinFieldAutoFill(
      controller: textController,
      inputFormatters: [PersianFormatter()],
      decoration: BoxLooseDecoration(
        strokeColorBuilder: FixedColorBuilder(Colors.grey),
        textStyle: const TextStyle(
            fontSize: 20, color: Colors.white, fontFamily: 'Peyda'),
        // colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
      ),
      currentCode: code,
      // This should be updated when SMS is received
      onCodeSubmitted: (code) {},
      // Empty callback
      codeLength: 5,
      onCodeChanged: (code) {
        print('********************');
        print(code);
        textController.text = code!.usePersianNumbers();
        if (textController.length == 5) {
          onCompleted?.call(code);
        }
        // if (code!.length == 6) {
        //   FocusScope.of(context).requestFocus(FocusNode());
        // }
      },
    );
  }
//   var focusedBorderColor = Colors.white;
//   var fillColor = AppColors.lightGrey;
//   const borderColor = Colors.white;
//
//   final defaultPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: const TextStyle(
//       fontSize: 16,
//       color: Colors.black,
//       fontFamily: 'Peyda',
//       fontWeight: FontWeight.w500
//     ),
//     decoration: BoxDecoration(
//       color: fillColor,
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(color: borderColor),
//     ),
//   );
//
//   return Form(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Pinput(
//           inputFormatters: [PersianFormatter()],
//
//          // smsRetriever: controller.smsRetriever,
//           controller:textController,
//           length: 5,
//           closeKeyboardWhenCompleted: true,
//           autofillHints: const [AutofillHints.oneTimeCode],
//           defaultPinTheme: defaultPinTheme,
//           separatorBuilder: (index) => const SizedBox(width: 8),
//           //validator: validator ?? controller.validatePin,
//           hapticFeedbackType: HapticFeedbackType.lightImpact,
//           onCompleted: onCompleted,
//           onChanged: (value) {
//             debugPrint('onChanged: $value');
//           },
//           cursor: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(bottom: 9),
//                 width: 22,
//                 height: 1,
//                 color: focusedBorderColor,
//               ),
//             ],
//           ),
//           focusedPinTheme: defaultPinTheme.copyWith(
//             decoration: defaultPinTheme.decoration!.copyWith(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: focusedBorderColor),
//             ),
//           ),
//           submittedPinTheme: defaultPinTheme.copyWith(
//             decoration: defaultPinTheme.decoration!.copyWith(
//               color: fillColor,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: focusedBorderColor),
//             ),
//           ),
//
//         ),
//         const SizedBox(height: 16),
//       ],
//     ),
//   );
// }
}

// class SmsRetrieverImpl implements SmsRetriever {
//   const SmsRetrieverImpl(this.smartAuth);
//
//   final SmartAuth smartAuth;
//
//   @override
//   Future<void> dispose() {
//     return smartAuth.removeSmsRetrieverApiListener();
//   }
//
//   @override
//   Future<String?> getSmsCode() async {
//     final signature = await smartAuth.getAppSignature();
//     debugPrint('App Signature: $signature');
//     final res = await smartAuth.getSmsWithRetrieverApi(
//     );
//     if (res.hasData) {
//       return res.data?.code!;
//     }
//     return null;
//   }
//
//   @override
//   bool get listenForMultipleSms => false;
// }
