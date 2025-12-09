import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/global_custom_widgets/bottom_sheet.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/outlined_button.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/sell/sell_controller.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import '../../global_custom_widgets/custom_check_box.dart';
import '../../global_custom_widgets/money_form.dart';

class SellPageView extends StatelessWidget {
  const SellPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    print('***');

    String? id;
    if (args != null && args is Map<String, dynamic> && args['id'] != null) {
      id = args['id'].toString();
    }
    final SellPageController controller = Get.put(SellPageController(id));

    return DarkBackgroundWidget(
      title: Strings.sell,
      hasCustomBack: true,
      onBackPressed: controller.getBack,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          switch (controller.step.value) {
            case SellPageStep.isFirstTime:
              return _buildFirstTime(context);
            case SellPageStep.isNotFirstTime:
              return _buildCarList(context);
            case SellPageStep.loading:
              return Center(child: loading());
            case SellPageStep.getMilage:
              return const GetMilageStep();
            case SellPageStep.khodEzhari:
              return const KhodEzhariStep();
            case SellPageStep.uploadPhoto:
              return UploadPhotoForm();
            case SellPageStep.showPaymentResult:
              return PaymentResultStep();
            default:
              return const Center(child: Text('در حال توسعه...'));
          }
        }),
      ),
    );
  }

  Widget _buildFirstTime(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image.asset('assets/emoji.png', height: 90),
            const SizedBox(height: 36),
            CustomText('کاربر گرامی شما تاکنون خودرویی جهت فروش ثبت نکرده‌اید',
                fontWeight: FontWeight.bold, size: 14),
            CustomText(
              'در صورت تمایل لطفا اطلاعات خودرو خود را وارد نمایید.',
              isRtl: true,
              fontWeight: FontWeight.bold,
              size: 14,
            ),
            const SizedBox(height: 16),
            ConfirmButton(
              () async {
                await Get.toNamed(RouteName.car);
                await Get.find<SellPageController>().getMyCars();
              },
              'افزودن خودرو',
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCarList(BuildContext context) {
    final controller = Get.find<SellPageController>();
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                // TextField(
                //   controller: controller.searchController,
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: Colors.transparent,
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //       borderSide: BorderSide(color: Colors.white, width: 1.0),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //       borderSide: BorderSide(color: Colors.white, width: 1.0),
                //     ),
                //     disabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //       borderSide: BorderSide(color: Colors.white, width: 1.0),
                //     ),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //       borderSide: BorderSide(color: Colors.white, width: 1.0),
                //     ),
                //     hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                //     counterText: "",
                //     hintText: 'جستجو بر اساس شماره شاسی',
                //     prefixIcon: const Icon(
                //       Icons.search,
                //       color: Colors.white,
                //     ),
                //     suffixIcon: IconButton(
                //       icon: const Icon(
                //         Icons.clear,
                //         color: Colors.white,
                //       ),
                //       onPressed: () {
                //         controller.searchController.clear();
                //         controller.getMyCars();
                //       },
                //     ),
                //   ),
                //   style: TextStyle(color: Colors.white, fontFamily: "Peyda"),
                //   onChanged: (value) => controller.getMyCars(),
                // ),
                CustomTextFormField(
              controller.searchController,
              maxLen: 17,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.searchController.clear();
                  controller.getMyCars();
                },
              ),

              hintText: 'جستجو بر اساس شماره شاسی                             ',
              // isChassiNumber: true,
              // validator: controller.validate,
              // exaxtLen: 17,
              autovalidateMode: controller.searchController.text.length == 17
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              onChanged: (s) {
                controller.getMyCars();
              },
              //errorText: 'شماره شاسی را به صورت صحیح وارد نمایید',
            )),
        const SizedBox(height: 20),
        CustomText(Strings.yourEnteredAddress, isRtl: true),
        const SizedBox(height: 20),
        Expanded(
          child: Obx(() => ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: controller.cars.length,
                itemBuilder: (context, index) {
                  final car = controller.cars[index];
                  return Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                      color: Colors.transparent,
                    ),
                    child: RadioListTile<int>(
                      title: CustomText(car.value, isRtl: false,textAlign: TextAlign.right),
                      value: car.id,
                      groupValue: controller.carId.value,
                      activeColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.white; // selected color
                        }
                        return Colors.white; // unselected color
                      }),
                      onChanged: (val) => controller.carId.value = val ?? 0,
                    ),
                  );
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ConfirmButton(
                controller.carId.value == 0
                    ? null
                    : () async {
                        var response = await DioClient.instance
                            .hasActiveOrderWithChassisNumber(
                                controller.carId.value.toString());
                        if (response?.status == 0) {
                          controller.step.value = SellPageStep.getMilage;
                        } else {
                          showToast(ToastState.ERROR,
                              "شما یک سفارش فعال با شماره شاسی وارد شده دارید!");
                        }
                      },
                'ادامه',
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: customOutlinedButton(
                      () async {
                        await Get.toNamed(RouteName.car);
                        controller.getMyCars();
                      },
                      'خودرو جدید',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GetMilageStep extends StatelessWidget {
  const GetMilageStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SellPageController>();
    final GlobalKey<FormState> mileageKey = GlobalKey<FormState>();
    return Form(
      key: mileageKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 26,
            ),
            CustomText('لطفا کارکرد خودروی مورد نظر را وارد کنید:',
                isRtl: true, fontWeight: FontWeight.bold, size: 15),
            const SizedBox(height: 30),
            Expanded(
              child: Obx(() => Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                                  onTap: () =>
                                      controller.milageStatus.value = 0,
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: controller
                                                          .milageStatus.value ==
                                                      0
                                                  ? AppColors.blue
                                                  : Colors.white),
                                          color:
                                              controller.milageStatus.value == 0
                                                  ? AppColors.blue
                                                  : Colors.transparent),
                                      child:
                                          Center(child: CustomText('صفر'))))),
                          Expanded(
                              child: InkWell(
                            onTap: () => controller.milageStatus.value = 1,
                            child: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color:
                                            controller.milageStatus.value == 1
                                                ? AppColors.blue
                                                : Colors.white),
                                    color: controller.milageStatus.value == 1
                                        ? AppColors.blue
                                        : Colors.transparent),
                                child: Center(child: CustomText('کارکرده'))),
                          ))
                        ],
                      ),
                      controller.milageStatus.value == 1
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MoneyForm(
                                controller.kilometerController,
                                hintText: 'کارکرد را وارد نمایید',
                                // isOnlyNumber: true,
                                maxLen: 7,
                              ),
                            )
                          : SizedBox(),
                    ],
                  )),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConfirmButton(
                () {
                  if (controller.milageStatus.value == 0) {
                    controller.step.value = SellPageStep.khodEzhari;
                    return;
                  }
                  if (mileageKey.currentState!.validate() &&
                      controller.kilometerController.text.toEnglishDigit() ==
                          '0') {
                    showToast(
                        ToastState.ERROR, 'مقدار صحیح کارکرد را وارد نمایید');
                    return;
                  }
                  if (mileageKey.currentState!.validate() &&
                      controller.kilometerController.text.isNotEmpty) {
                    controller.step.value = SellPageStep.khodEzhari;
                  }
                },
                'ادامه',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadPhotoForm extends StatelessWidget {
  final SellPageController controller = Get.find<SellPageController>();
  final GlobalKey<FormState> _otherInfoFormKey = GlobalKey<FormState>();

  UploadPhotoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText('لطفا جزئیات خودروی مورد نظر را وارد کنید.',
                    size: 16, fontWeight: FontWeight.w500, isRtl: true),
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText('چه کسی خودرو را برای کارشناسی خواهد برد؟ ')
              ],
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    controller.otherWillTakeCar.value
                        ? InkWell(
                            onTap: () {
                              showGetOtherInfoDialog(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: SvgPicture.asset(
                                    'assets/edit.svg',
                                    height: 18,
                                    color: Colors.white,
                                  )),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 8,
                    ),
                    CustomCheckBox(
                        isBlue: true,
                        value: !controller.otherWillTakeCar.value,
                        onChanged: (value) {
                          controller.otherWillTakeCar.value = !(value ?? true);
                        }),
                    CustomText('خودم'),
                    SizedBox(
                      width: 24,
                    ),
                    CustomCheckBox(
                        isBlue: true,
                        value: controller.otherWillTakeCar.value,
                        onChanged: (value) async {
                          var changed =
                              await showGetOtherInfoDialog(context) ?? false;
                          if (changed) {
                            controller.otherWillTakeCar.value = true;
                          }
                        }),
                    CustomText('سایر'),
                  ],
                )),

            SizedBox(
              height: 8,
            ),
            Obx(() => CustomDropdown(
                hint: 'شهر',
                largeFont: true,
                value: controller.selectedCity.value,
                items: controller.cities,
                isRtl: true,
                isTurn: controller.step.value == SellPageStep.uploadPhoto,
                onChanged: (String? str) => controller.onCitySelected(str))),
            SizedBox(
              height: 8,
            ),
            Obx(() => CustomDropdown(
                hint: 'آدرس نمایندگی',
                value: controller.selectedAddress.value,
                items: controller.addresses,
                isTurn: controller.selectedCity.value != null,
                isFullLine: true,
                isRtl: true,
                onChanged: (String? str) => controller.onAddressSelected(str))),

            SizedBox(
              height: 8,
            ),
            Obx(() => CustomDropdown(
                hint: 'کارشناس راهنما',
                value: controller.selectedKarshenas.value,
                items: controller.karshenasList,
                isRtl: true,
                isTurn: controller.selectedAddress.value != null,
                onChanged: (String? str) =>
                    controller.onKarshenasSelected(str))),
            SizedBox(
              height: 8,
            ),
            MoneyForm(
              controller.amountController,
              hintText: 'قیمت اظهاری به تومان',
              maxLen: 15,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            SizedBox(
              height: 8,
            ),
            CustomTextFormField(controller.commentController,
                autovalidateMode: AutovalidateMode.disabled,
                maxLen: 200,
                hintText: 'توضیحات شما'),

            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () => controller.pickImages(),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => controller.images.isNotEmpty &&
                            controller.base64Images.isNotEmpty
                        ? Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      controller.images.length.clamp(0, 5),
                                  itemBuilder: (ctx, index) {
                                    return Chip(
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      label: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: imageFromBase64String(
                                              controller.base64Images[index]!,
                                              20)),
                                      onDeleted: () =>
                                          controller.removeImage(index),
                                      deleteIcon: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                    );
                                  }),
                            ),
                          )
                        : Center(
                            child: CustomText(
                                'بارگذاری عکس                      ',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                size: 14),
                          )),
                    SizedBox(
                      width: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SvgPicture.asset(
                        'assets/share.svg',
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => controller.isSwap.value
                ? Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                        controller.swapCommentController,
                        maxLen: 200,
                        acceptAll: true,
                        hintText: 'توضیحات تعویض',
                      ),
                    ],
                  )
                : SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => CustomCheckBox(
                    isBlue: true,
                    value: controller.isSwap.value,
                    onChanged: (val) =>
                        controller.isSwap.value = val ?? false)),
                SizedBox(
                  width: 8,
                ),
                CustomText('مایل به تعویض هستم.', isRtl: true),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Obx(() => controller.isLoading.value
                ? Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: loading(),
                    ),
                  )
                : ConfirmButton(
                    () => controller.submitRequest(),
                    'ادامه ',
                    borderRadius: 8,
                    txtColor: Colors.white,
                  )),
            SizedBox(
              height: 8,
            ),
            //CancelButton(context),
          ],
        ),
      ),
    );
  }

  Future<bool?> showGetOtherInfoDialog(BuildContext context) async {
    return CustomBottomSheetAnimated.show(
      context: context, // Use the passed context instead of Get.context!
      initialChildSize: 0.45,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _otherInfoFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText('برای تکمیل اطلاعات لطفا از حروف فارسی استفاده کنید.',
                  isRtl: true,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                controller.nameController,
                maxLen: 20,
                isDark: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: 'نام مراجعه کننده',
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller.lastNameController,
                maxLen: 30,
                isDark: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: 'نام خانوادگی مراجعه کننده',
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller.nationalCodeController,
                maxLen: 10,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                isNationalId: true,
                isDark: true,
                hintText: 'کدملی مراجعه کننده',
              ),
              const SizedBox(height: 8),
              ConfirmButton(
                () {
                  if (_otherInfoFormKey.currentState!.validate()) {
                    controller.otherWillTakeCar.value = true;
                    Navigator.of(context).pop(true);
                  }
                },
                'تایید',
                txtColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShowTarefeStep extends StatelessWidget {
  const ShowTarefeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SellPageController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => CustomText(
              'بر اساس اطلاعات وارد شده تعرفه کارشناسی: ${controller.tarefe.value}   میباشد که بعد از انجام مراحل کارشناسی در محل تسویه خواهد شد. تومان',
              fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Obx(() => CheckboxListTile(
                title: const Text('شرایط و قوانین را می‌پذیرم'),
                value: controller.hasConfirmedRules.value,
                onChanged: (val) =>
                    controller.hasConfirmedRules.value = val ?? false,
              )),
          ConfirmButton(
            controller.hasConfirmedRules.value
                ? () {
                    controller.insertRequest();
                  }
                : null,
            'ثبت درخواست فروش',
            color: Colors.green,
            txtColor: Colors.white,
          )
        ],
      ),
    );
  }
}

class PaymentResultStep extends StatelessWidget {
  const PaymentResultStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SellPageController>();
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade800),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/ok.svg'),
            const SizedBox(height: 16),
            CustomText('سفارش شما با موفقیت ثبت شد!',
                fontWeight: FontWeight.bold, isRtl: true),
            const SizedBox(height: 16),
            CustomText(
                'کارشناسان ما جهت هماهنگی در اسرع وقت با شما تماس خواهند گرفت.',
                isRtl: true),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            CustomText('کد رهگیری :', isRtl: true, size: 14),
            const SizedBox(height: 8),
            Obx(() => Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white)),
                          child: Center(
                              child: CustomText(
                                  '${controller.orderNumber.value}'
                                      .usePersianNumbers(),
                                  size: 14))),
                    ),
                  ],
                )),
            const SizedBox(height: 24),
            ConfirmButton(
              () => Get.back(),
              'بازگشت',
            )
          ],
        ),
      ),
    );
  }
}

class KhodEzhariStep extends StatelessWidget {
  const KhodEzhariStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SellPageController>();

    final List<Color> damageColors = [
      AppColors.khatokhash,
      AppColors.safkari,
      AppColors.zarebekhorde,
      AppColors.rangshode,
      AppColors.taviz
    ];

    final List<String> labels = [
      'خط و خش',
      'صافکاری بی رنگ',
      'ضربه خورده',
      'رنگ شده',
      'تعویض شده'
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText('لطفا قسمت‌های آسیب‌دیده خودرو را مشخص نمایید.',
                size: 16, isRtl: true, fontWeight: FontWeight.w500),
            const SizedBox(height: 42),
            GestureDetector(
              onTapDown: (details) {
                // Check if a color is selected
                if (controller.selectedColorIndex.value == 8) {
                  showToast(ToastState.INFO,
                      'ابتدا نوع آسیب دیدگی را با انتخاب رنگ متناسب با آن مشخص کنید.');
                  return;
                }
                if (controller.selectedColorIndex.value >= 0) {
                  final selectedColor =
                      damageColors[controller.selectedColorIndex.value];
                  controller.addDot(Dot(details.localPosition.dx,
                      details.localPosition.dy, selectedColor));
                } else {
                  // Show toast (implement the toast functionality)
                }
              },
              child: Container(
                height: 300, // Adjust this to match your image_height() value
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/car_paint.png',
                      ),
                    ),
                    Obx(() => Stack(
                          children: controller.positions.map((position) {
                            return Positioned(
                              top: position.y,
                              left: position.x,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: position.color),
                                width: 8,
                                height: 8,
                              ),
                            );
                          }).toList(),
                        )),
                    Positioned(
                      top: 1,
                      left: 10,
                      child: Obx(() => controller.positions.isNotEmpty
                          ? InkWell(
                              onTap: () => controller.undoLastDot(),
                              child: const Icon(
                                Icons.arrow_circle_left_outlined,
                                color: Colors.white,
                                size: 34,
                              ))
                          : const SizedBox()),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildColorItem(controller, 'رنگ شده', AppColors.rangshode, 3),
                const SizedBox(height: 8),
                buildColorItem(
                    controller, 'صافکاری بی رنگ', AppColors.safkari, 1),
              ],
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              buildColorItem(controller, 'تعویض شده', AppColors.taviz, 4),
              const SizedBox(height: 8),
              buildColorItem(
                  controller, 'ضربه خورده', AppColors.zarebekhorde, 2)
            ]),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildColorItem(controller, 'خط و خش', AppColors.khatokhash, 0),
                SizedBox(),
              ],
            ),
            const SizedBox(height: 24),
            ConfirmButton(
              () => controller.step.value = SellPageStep.uploadPhoto,
              'ادامه',
              txtColor: const Color(0xFFFFFFFF),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget buildColorItem(
      SellPageController controller, String title, Color color, int id) {
    return Obx(() => Container(
          width: 120,
          height: 40,
          child: InkWell(
            onTap: () => controller.setSelectedColor(id),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.selectedColorIndex.value == id
                          ? color
                          : Colors.transparent,
                      border: Border.all(color: color, width: 2)),
                  height: 14,
                  width: 14,
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: CustomText(title,
                        fontWeight: FontWeight.bold,
                        size: 15,
                        isRtl: true,
                        textAlign: TextAlign.right)),
              ],
            ),
          ),
        ));
  }
}
