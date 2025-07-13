// import 'package:get/get.dart';
// import 'package:sigma/helper/dio_repository.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class WalletController extends GetxController {
//   final balance = 0.0.obs;
//   final userName = ''.obs;
//   final isLoading = false.obs;
//   final errorMessage = ''.obs;
//   final currentView = WalletView.card.obs;
//
//   @override
//   void onInit() {
//     fetchWalletData();
//     super.onInit();
//   }
//
//   Future<void> fetchWalletData() async {
//     isLoading(true);
//     try {
//       // Replace with your actual data fetching logic
//       final userInfo = await DioClient.instance.getUserInfo();
//       if (userInfo != null && userInfo.message == 'OK') {
//         balance.value = double.tryParse(userInfo.account?.balance ?? '0') ?? 0.0;
//         userName.value = '${userInfo.account?.name ?? ''} ${userInfo.account?.lastName ?? ''}';
//       }
//     } catch (e) {
//       errorMessage.value = 'Failed to load wallet data';
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> increaseBalance(double amount) async {
//     isLoading(true);
//     try {
//       // Replace with your actual payment logic
//       final response = await DioClient.instance.raiseCredit(amount.toString());
//       if (response?.bankUrl != null && response!.bankUrl!.isNotEmpty) {
//         await launchUrl(Uri.tryParse(response.bankUrl)!, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       errorMessage.value = 'Failed to increase balance';
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void changeView(WalletView view) {
//     currentView.value = view;
//   }
// }
//
// enum WalletView { card, increase }