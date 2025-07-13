import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/application_info_model.dart';
import 'package:url_launcher/url_launcher.dart';

Widget infoBanner(BuildContext context, Infos? info, {double padding = 8}) {
  if (info == null) return SizedBox.shrink();

  return Padding(
    padding: EdgeInsets.all(padding),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          _buildImage(info),
          if (info.enable != '1') _buildExpiredOverlay(),
          // if (info.url != null && info.enable == '1')
          //   _buildMoreInfoButton(context, info),
        ],
      ),
    ),
  );
}

Widget _buildImage(Infos info) {
  return InkWell(
    onTap: () => navigateToBanner(info),
    child: Image.network(
      '${URLs.imageLinks}${info.docId ?? ""}',
      fit: BoxFit.fill,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: 60,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildExpiredOverlay() {
  return Positioned.fill(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        color: Colors.black.withOpacity(0),
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CustomText(
              Strings.expires,
              color: AppColors.orange,
              size: 12,
            ),
          ),
        ),
      ),
    ),
  );
}

// Widget _buildMoreInfoButton(BuildContext context, Infos info) {
//   return Positioned(
//     bottom: 8,
//     right: 20,
//     child: InkWell(
//       onTap: () => navigateToBanner(info),
//       child: Container(
//         margin: const EdgeInsets.all(8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: CustomText(
//           'اطلاعات بیشتر',
//           color: Colors.black87,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   );
// }

void navigateToBanner(Infos info) {
  if (info.currentTab == '1') {
    Get.toNamed(info.url ?? RouteName.home);
  } else {
    if (info.url != null) launchUrl(Uri.parse(info.url!));
  }
}
