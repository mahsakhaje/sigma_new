import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/helper/helper.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdf extends StatefulWidget {
  const Pdf({super.key});

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Add null safety and type checking
    final args = Get.arguments;

    // Check if args is null or not a Map
    if (args == null || args is! Map<String, dynamic>) {
      return DarkBackgroundWidget(
        title: '',
        child:  Center(
          child: CustomText('متاسفانه فایل یافت نشد!',isRtl: true,fontWeight: FontWeight.bold),
        ),
      );
    }

    // Check if url exists and is a String
    final url = args['url'];
    print(url);
    if (url == null || url is! String || url.isEmpty) {
      return DarkBackgroundWidget(
        title: '',
        child:  Center(
          child: CustomText('متاسفانه فایل یافت نشد!',isRtl: true,fontWeight: FontWeight.bold),
        ),
      );
    }

    return DarkBackgroundWidget(
      title: '',
      child: Stack(
        children: [
          SfPdfViewer.network(
            url,
            key: _pdfViewerKey,
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              print('PDF load failed: ${details.error}');
            },
          ),
          Positioned(
            bottom: 20,
            width: MediaQuery.of(context).size.width > 700
                ? 700
                : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConfirmButton(
                    () async {
                  try {
                    final response = await http.get(Uri.parse(url));
                    final bytes = response.bodyBytes;
                    if(defaultTargetPlatform == TargetPlatform.android){
                      var path = await saveFileToDownloads('loan', bytes);
                      print(path);

                    }else{
                      var path = await saveFile('loan', bytes);
                      print(path);
                    }
                  } catch (e) {
                    print('Download failed: $e');
                    // Show error message to user
                    Get.snackbar('خطا', 'دانلود ناموفق بود');
                  }
                },
                'دانلود',
              ),
            ),
          )
        ],
      ),
    );
  }
}