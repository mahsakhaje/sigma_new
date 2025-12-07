import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/no_content.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/models/stocks_model.dart';
import 'package:sigma/pages/advertise/stocks/filter_widget.dart';
import 'package:sigma/pages/advertise/stocks/stocks_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class StocksPage extends StatelessWidget {
  const StocksPage({super.key});

  @override
  Widget build(BuildContext context) {
    StocksController controller = Get.put(StocksController());

    return DarkBackgroundWidget(
        child: Obx(() => _buildBody(controller)), title: Strings.stocks);
  }

  Widget _buildBody(StocksController controller) {
    if (controller.isLoading.value) {
      return Center(
        child: loading(),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildTabs(controller),
        Container(
          color: Colors.white,
          height: 1,
          width: MediaQuery.of(Get.context!).size.width,
        ),
        SizedBox(
          height: 8,
        ),
        GestureDetector(
          child: SvgPicture.asset('assets/filter.svg'),
          onTap: () => _showFilterBottomSheet(controller),
        ),
        Expanded(
            child: Padding(
          child: _buildList(controller),
          padding: EdgeInsets.all(10),
        ))
      ],
    );
  }

  void _showFilterBottomSheet(StocksController controller) {
    CustomBottomSheet.show(
        context: Get.context!,
        child: StocksFilterWidget(controller: controller),
        initialChildSize: controller.tab == TabStatus.TOTAL ? 0.3 : 0.7);
  }

  _buildTabs(StocksController controller) {
    return Obx(() => Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                if (controller.tab == TabStatus.TOTAL) {
                  return;
                }
                controller.toggleTab();
              },
              child: Container(
                  height: 60,
                  color: controller.tab.value == TabStatus.USUAL
                      ? Colors.transparent
                      : AppColors.lightGrey,
                  child: Center(
                    child: CustomText('موجودی کل',
                        size: 16, fontWeight: FontWeight.bold),
                  )),
            )),
            Container(
              width: 1,
              color: Colors.white,
              height: 60,
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {
                if (controller.tab == TabStatus.USUAL) {
                  return;
                }
                controller.toggleTab();
              },
              child: Container(
                  height: 60,
                  color: controller.tab.value == TabStatus.TOTAL
                      ? Colors.transparent
                      : AppColors.lightGrey,
                  child: Center(
                      child: CustomText('موجودی',
                          size: 16, fontWeight: FontWeight.bold))),
            )),
          ],
        ));
  }
}

_buildList(StocksController controller) {
  if (controller.tab == TabStatus.TOTAL) {
    if (controller.totalStocks.isEmpty) {
      return NoContent();
    }
    return ListView.builder(
        itemCount: controller.totalStocks.value.length,
        itemBuilder: (ctx, index) {
          return stocksItem(
              controller.totalStocks.value[index], controller.tab.value,controller);
        });
  }
  if (controller.stocks.isEmpty) {
    return NoContent();
  }
  return ListView.builder(
      itemCount: controller.stocks.value.length,
      itemBuilder: (ctx, index) {
        return stocksItem(controller.stocks.value[index], controller.tab.value,controller);
      });
}

Widget stocksItem(Stocks stock, TabStatus status,StocksController controller) {
  return Card(
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: Get.context!,
                      builder: (_) => AlertDialog(
                        insetPadding: EdgeInsets.all(8),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomText(
                                        'جهت اطلاعات بیشتر با واحد فروش و عملیات تماس بگیرید.',
                                        color: Colors.black,
                                        isRtl: true,
                                        fontWeight: FontWeight.bold,size: 12),


                                  ],
                                ),
                                SizedBox(height: 16,),
                                showRoomNumber(controller.firstNumber),
                                showRoomNumber(controller.secondNumber),
                                showRoomNumber(controller.thirdNumber),
                              ],
                            ),
                          ));
                },
                child: SvgPicture.asset(
                  'assets/more.svg',
                  color: Colors.black,
                ),
              ),
              CustomText(status == TabStatus.TOTAL ? 'موجودی کل:' : 'موجودی:',
                  isRtl: true, color: Colors.black, fontWeight: FontWeight.bold)
            ],
          ),
        ),
        Center(
          child: CustomText((stock.count ?? '').usePersianNumbers(),
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Divider(
          color: AppColors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText('خودرو:',
                  isRtl: true,
                  textAlign: TextAlign.right,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        status == TabStatus.TOTAL
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(stock.carType ?? "",
                        color: Colors.black, fontWeight: FontWeight.bold),
                    Container(
                      width: 1,
                      height: 20,
                      color: AppColors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                    ),
                    CustomText(stock.carModel ?? "",
                        color: Colors.black, fontWeight: FontWeight.bold),
                    Container(
                        width: 1,
                        height: 20,
                        color: AppColors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 4)),
                    CustomText(stock.brand ?? "",
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomText(stock.persianYear ?? "",
                      color: Colors.black, fontWeight: FontWeight.bold),
                  Container(
                    width: 1,
                    height: 20,
                    color: AppColors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                  ),
                  CustomText((stock.mileage ?? "") == "0" ? 'صفر' : 'کارکرده',
                      color: Colors.black, fontWeight: FontWeight.bold),
                  Container(
                    width: 1,
                    height: 20,
                    color: AppColors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                  ),
                  CustomText(stock.carType ?? "",
                      color: Colors.black, fontWeight: FontWeight.bold),
                  Container(
                    width: 1,
                    height: 20,
                    color: AppColors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                  ),
                  CustomText(stock.carModel ?? "",
                      color: Colors.black, fontWeight: FontWeight.bold),
                  Container(
                      width: 1,
                      height: 20,
                      color: AppColors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 4)),
                  CustomText(stock.brand ?? "",
                      color: Colors.black, fontWeight: FontWeight.bold),
                ]))
      ],
    ),
  );
}
Widget showRoomNumber(String number) {
  return InkWell(
    onTap: () async {
      if (number.isNotEmpty) {
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: number,
        );
        await launchUrl(launchUri);
      }
    },
    child: Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.lightGrey),
      child: Wrap(
        children: [
          Icon(
            Icons.call_outlined,
            size: 18,
            color: Colors.black ,
          ),
          CustomText(
            number.usePersianNumbers(),
            color:  Colors.black ,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    ),
  );
}
