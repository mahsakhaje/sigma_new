// import 'dart:ui';
//
// import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sigma/global_custom_widgets/confirm_button.dart';
// import 'package:sigma/global_custom_widgets/custom_text.dart';
// import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
// import 'package:sigma/helper/colors.dart' as colors;
// import 'package:sigma/helper/colors.dart';
// import 'package:sigma/helper/helper.dart';
// import 'package:sigma/helper/route_names.dart';
// import 'package:sigma/helper/strings.dart';
// import 'package:sigma/pages/profile/wallet/wallet_controller.dart';
//
// class WalletPage extends StatelessWidget {
//   final bool returnToHomeOnBackPressed;
//
//   const WalletPage({super.key, required this.returnToHomeOnBackPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(WalletController());
//
//     return DarkBackgroundWidget(
//       title: Strings.raise_credit,
//       child:  Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: loading());
//           }
//
//           if (controller.errorMessage.value.isNotEmpty) {
//             return Center(child: Text(controller.errorMessage.value));
//           }
//
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: controller.currentView.value == WalletView.card
//                   ? _buildCardView(controller)
//                   : _buildIncreaseView(controller),
//             ),
//           );
//         }),
//
//     );
//   }
//
//   void _handleBackPressed(WalletController controller, BuildContext context) {
//     if (controller.currentView.value == WalletView.increase) {
//       controller.changeView(WalletView.card);
//     } else if (returnToHomeOnBackPressed) {
//       Get.toNamed(RouteName.home);
//     } else {
//       Navigator.of(context).pop();
//     }
//   }
//
//   Widget _buildCardView(WalletController controller) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 9.0, sigmaY: 4.0),
//             child: Container(
//               height: 220,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey),
//                 color: Colors.grey.withOpacity(0.3),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Image.asset('assets/en_sigma.png', height: 18),
//                          CustomText('موجودی شما', size: 16),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomText('تومان', size: 20),
//                         CustomText(
//                           NumberUtils.separateThousand(controller.balance.value.toInt())
//                               .usePersianNumbers(),
//                           size: 20,
//                         ),
//                         const SizedBox(),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         CustomText(controller.userName.value, size: 16),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 26),
//           Row(
//             children: [
//               Expanded(
//                 child: ConfirmButton(
//                       () => controller.changeView(WalletView.increase),
//                   'افزایش',
//                   color: AppColors.blue,
//                   txtColor: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIncreaseView(WalletController controller) {
//     final priceController = TextEditingController();
//
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               CustomText(
//                 'موجودی شما: ${NumberUtils.separateThousand(controller.balance.value.toInt())} تومان'
//                     .usePersianNumbers(),
//                 size: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 26),
//         Directionality(
//           textDirection: TextDirection.rtl,
//           child: CustomRadioButton(
//             horizontal: false,
//             enableShape: true,
//             radius: 15,
//             selectedBorderColor: AppColors.blue,
//             height: 56,
//             elevation: 0,
//             shapeRadius: 15,
//             padding: 1,
//             width: 90,
//             autoWidth: true,
//             buttonTextStyle: ButtonTextStyle(
//               selectedColor: colors.darkBlue,
//               textStyle: const TextStyle(color: Colors.black87, fontSize: 11),
//               unSelectedColor: Colors.black87,
//             ),
//             unSelectedColor: Colors.white,
//             buttonLables: [
//               '500 هزار تومان'.usePersianNumbers(),
//               '800 هزار تومان'.usePersianNumbers(),
//               ' 1 میلیون تومان'.usePersianNumbers(),
//             ],
//             buttonValues: [5, 8, 10],
//             defaultSelected: 5,
//             radioButtonValue: (value) {
//               if (value == 10) {
//                 priceController.text = '1,000,000'.usePersianNumbers();
//                 return;
//               }
//               priceController.text = '${value ?? '0'}00,000'.usePersianNumbers();
//             },
//             selectedColor: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 50),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: MoneyForm(
//             priceController,
//             hintText: 'مبلغ به تومان',
//             showToman: priceController.text.isNotEmpty,
//             onChanged: (val) {},
//           ),
//         ),
//         const SizedBox(height: 50),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: ConfirmButton(
//                       () => _handlePayment(controller, priceController.text),
//                   'پرداخت نهایی',
//                   color: colors.darkBlue,
//                   txtColor: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<void> _handlePayment(WalletController controller, String amountText) async {
//     hideKeyboard(context);
//     String amount = '';
//
//     if (amountText.contains('تومان')) {
//       amount = englishToPersian(amountText
//           .replaceAll(' \u06F1 میلیون تومان', '1000')
//           .replaceAll("هزار تومان", '')) +
//           '000';
//       amount = amount.replaceAll('تومان', '');
//     } else {
//       amount = amountText;
//     }
//
//     final parsedAmount = double.tryParse(
//       englishToPersian(amount.replaceAll(',', '')).replaceAll('٬', ''),
//     );
//
//     if (parsedAmount != null) {
//       await controller.increaseBalance(parsedAmount);
//     }
//   }
// }