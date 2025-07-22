import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';
import 'package:sigma/routes.dart';

class carItem extends StatefulWidget {
  BuildContext context;
  SalesOrders order;
  bool isFavorite = false;
  VoidCallback onTap;

  carItem(this.context, this.order, this.onTap,
      {this.isFavorite = false, Key? key})
      : super(key: key);

  @override
  State<carItem> createState() => _carItemState();
}

class _carItemState extends State<carItem> {
  bool isLoading = false;
  double height = 130;

  @override
  Widget build(BuildContext context) {
    var order = widget.order;
    String imageUrl = '${URLs.imageLinks}${order.salesOrderDocuments?[0].docId ?? ""}';
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.carDetails, arguments: {'id': order.id});

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8)
        ),
        margin: EdgeInsets.symmetric(vertical: 9, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                height: height,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(order.persianYear ?? '',
                                fontWeight: FontWeight.bold,
                                size: 14),
                            SizedBox(
                              width: 4,
                            ),
                            Container(
                              width: 2,
                              height: 14,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            CustomText(order.carModelDescription ?? '',
                                fontWeight: FontWeight.bold,
                                size: 14),
                            SizedBox(
                              width: 4,
                            ),
                            Container(
                              width: 2,
                              height: 14,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            CustomText(order.brandDescription ?? '',
                                fontWeight: FontWeight.bold,
                                size: 14),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (widget.isFavorite)
                                ? InkWell(
                                    onTap: () async {
                                      var response = await DioClient.instance
                                          .changeLike(id: order.id ?? '');
                                      widget.onTap();
                                    },
                                    child: SvgPicture.asset('assets/delete.svg',
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      var response = await DioClient.instance
                                          .changeLike(id: order.id ?? '');
                                      widget.onTap();
                                      await Future.delayed(
                                          Duration(milliseconds: 300),
                                          () async {});

                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    child: isLoading
                                        ? SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: loading(),
                                            ))
                                        : (widget.isFavorite) ||
                                                order.favCount != null &&
                                                    (int.tryParse(order
                                                                .favCount!) ??
                                                            0) ==
                                                        1
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/red_heart.svg',
                                                  width: 16,
                                                  color: Colors.red,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/heart.svg',
                                                  width: 16,
                                                ),
                                              ),
                                  ),
                            CustomText(
                                'قیمت' +
                                    ' : ' +
                                    NumberUtils.separateThousand(int.tryParse(
                                                order.advertiseAmount ?? '0') ??
                                            0)
                                        .usePersianNumbers() +
                                    ' تومان ',
                               ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            order.salesOrderDocuments == null
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    child: Container(
                      color: AppColors.lightGrey,
                      height: height,
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 28, horizontal: 18),
                        child: SvgPicture.asset('assets/no_pic.svg'),
                      ),
                    ))
                : ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print(error);
                      return Container(
                        height: height,
                        width: 170,
                        color: Colors.grey.shade200,
                        child: const Center(child: Text('Image not available')),
                      );
                    }, height: height, width: 170)),
          ],
        ),
      ),
    );
  }
}
