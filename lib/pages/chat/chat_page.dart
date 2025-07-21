// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter/foundation.dart';
// import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
//
// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final localhostServer = InAppLocalhostServer(documentRoot: 'assets');
//   late InAppWebViewController _webViewController;
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
//        await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
//       }
//
//       if (!kIsWeb) {
//         await localhostServer.start();
//       }
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DarkBackgroundWidget(
//       title: 'پشتیبان',
//       child:  InAppWebView(
//         initialUrlRequest:
//         URLRequest(url: WebUri('https://www.goftino.com/c/j2kPkF')),
//         onWebViewCreated: (controller) async {
//           _webViewController = controller;
//         },
//       ),
//     );
//   }
// }