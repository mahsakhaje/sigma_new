import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/models/blog_response_model.dart';
import 'package:sigma/pages/blog/sigma_news_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class AllBlogsPage extends StatelessWidget {
  AllBlogsPage({Key? key}) : super(key: key);

  final AllBlogsController controller = Get.put(AllBlogsController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: 'اخبار خودرویی',
      child: Obx(() {
        if (controller.isLoading.value && controller.newsList.isEmpty) {
          return  Center(child: loading());
        }

        if (controller.newsList.isEmpty) {
          return NoContent();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          controller: controller.scrollController,
          itemCount: controller.hasMore.value
              ? controller.newsList.length + 1
              : controller.newsList.length,
          itemBuilder: (ctx, index) {
            if (index == controller.newsList.length &&
                controller.hasMore.value) {
              return  Center(child: loading());
            }

            return NewsItemWidget(controller.newsList[index], context);
          },
        );
      }),
    );
  }

  Widget NewsItemWidget(News news, BuildContext context) {
    final titleText =
        html_parser.parse(news.title ?? '').documentElement?.text ?? '';

    return SizedBox(
      height: 270,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            news.imageUrl == null
                ? ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Container(
                      color: AppColors.lightGrey,
                      height: 180,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 36, horizontal: 18),
                        child: SvgPicture.asset('assets/no_pic.svg'),
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      news.imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 2),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomText(
                      titleText,
                      size: 14,
                      maxLine: 2,
                      isRtl: true,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () {
                      if (news.link != null) {
                        launchUrl(Uri.parse(news.link!));
                      }
                    },
                    child: CustomText('وبلاگ ایستگاه', color: AppColors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
