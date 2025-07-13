import 'package:flutter/material.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';

class NetworkErrorWidget extends StatefulWidget {
  VoidCallback onRetry;

  NetworkErrorWidget({Key? key, required this.onRetry}) : super(key: key);

  @override
  State<NetworkErrorWidget> createState() => _NetworkErrorWidgetState();
}

class _NetworkErrorWidgetState extends State<NetworkErrorWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/noInternet.png',
              height: 280,
            ),
          ),
          SizedBox(height: 24),
          CustomText('متاسفانه در برقراری ارتباط خطا رخ داده است'),
          CustomText('لطفا دسترسی به اینترنت را بررسی نمایید و مجدد تلاش کنید'),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.onRetry,
            child: CustomText('تلاش مجدد', color: AppColors.blue),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          )
        ],
      ),
    );
  }
}
