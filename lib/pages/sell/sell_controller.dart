import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, XFile;
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/models/available_account_manager.dart';
import 'package:sigma/models/my_cars_model.dart';
import 'package:sigma/models/user_info_model.dart';

import '../../helper/colors.dart';
import '../advertise/advertise_controller.dart';

enum SellPageStep {
  getMilage,
  isFirstTime,
  isNotFirstTime,
  uploadPhoto,
  khodEzhari,
  showTarefe,
  showPaymentResult,
  loading,
}

class Dot {
  double x;
  double y;
  Color color;

  Dot(this.x, this.y, this.color);
}

class SellPageController extends GetxController {
  // --- States ---
  final step = SellPageStep.loading.obs;
  final isLoading = false.obs;
  final hasConfirmedRules = false.obs;
  final useCredit = false.obs;
  final isSwap = false.obs;
  final otherWillTakeCar = false.obs;
  var selectedColorIndex = 8.obs;

  // --- Form Controllers ---
  final searchController = TextEditingController();
  final amountController = TextEditingController();
  final commentController = TextEditingController();
  final swapCommentController = TextEditingController();
  final kilometerController = TextEditingController();
  final nationalCodeController = TextEditingController();
  final codeTakhfifController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  // --- Selection States ---
  final carId = 0.obs;
  final milageStatus = 0.obs;
  final selectedCity = RxnString();
  final cityId = RxnString();
  final selectedAddress = RxnString();
  final selectedKarshenas = RxnString();

  final cars = <TimeValue>[].obs;
  final base64Images = <String?>[].obs;
  final images = <XFile?>[].obs;
  final positions = <Dot>[].obs;

  final tarefe = ''.obs;
  final orderId = ''.obs;
  final showRoomId = ''.obs;
  final karshenasId = ''.obs;
  final timeId = ''.obs;
  final date = ''.obs;
  final factorNumber = ''.obs;
  final orderNumber = ''.obs;
  final totalPrice = ''.obs;
  final discountPrice = ''.obs;
  final paidPrice = ''.obs;
  final dargahAmount = ''.obs;

  final cities = <String, String>{}.obs;
  final addresses = <String, String>{}.obs;
  final karshenasList = <String, String>{}.obs;

  final scrollController = ScrollController();

  UserInfoResponse? userInfoResponse;
  MyCarsResponse? myCarsResponse;
  AvailableAccountManagersResponse? karshenasResponse;
  Account? account;
  bool isFromContinue = false;
  final picker = ImagePicker();

  SellPageController(String? id) {
    if ((id?.isEmpty ?? false) || id == null) {
    } else {
       isFromContinue = true;

      carId.value = int.tryParse(id!) ?? 0;
      print(carId);
      step.value = SellPageStep.getMilage;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    userInfoResponse = await DioClient.instance.getUserInfo();
    if (userInfoResponse?.message == 'OK') {
      account = userInfoResponse?.account;
    }

    final a = await DioClient.instance.getShowroomCities();
    if (a?.message == 'OK') {
      for (final e in a!.geoNames ?? []) {
        if (e.id != null && e.description != null) {
          cities[e.id!] = e.description!;
        }
      }
    }
if(isFromContinue){
  return;
}
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await getMyCars();
      }
    });

    await getMyCars();
    if (cars.value.isEmpty && searchController.text.isEmpty) {
      step.value = SellPageStep.isFirstTime;
    } else {
      step.value = SellPageStep.isNotFirstTime;
    }
    //step.value = SellPageStep.isNotFirstTime;
  }

  Future<void> getMyCars() async {
    isLoading.value = true;
    cars.clear();
    myCarsResponse = await DioClient.instance
        .getMycars(query: searchController.text, pn: 1, pl: 100);
    isLoading.value = false;

    if (myCarsResponse?.cars != null && myCarsResponse!.cars!.isNotEmpty) {
      if (searchController.text.isNotEmpty) {
        cars.clear();
      }
      for (final car in myCarsResponse!.cars!) {
        final description =
            "${car.brandDescription ?? ''} ${car.carModelDescription ?? ''} - ${car.colorDescription ?? ''}";
        cars.add(TimeValue(int.tryParse(car.id ?? '0')!, description));
      }
      if (cars.isEmpty && searchController.text.isEmpty) {
        step.value = SellPageStep.isFirstTime;
      } else {
        step.value = SellPageStep.isNotFirstTime;
      }
    }
  }

  Future<void> pickImages() async {
    if (images.length >= 5) {
      Get.snackbar('خطا', 'حداکثر ۵ عکس مجاز است');
      return;
    }
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      images.addAll(picked);
      base64Images.clear();
      for (final image in images) {
        final bytes = await image!.readAsBytes();
        base64Images.add(base64Encode(bytes));
      }
    }
  }

  void addDot(Dot dot) {
    positions.add(dot);
  }

  void undoLastDot() {
    if (positions.isNotEmpty) {
      positions.removeLast();
    }
  }

  void setSelectedColor(int index) {
    selectedColorIndex.value = index;
  }

  Future<void> onCitySelected(String? str) async {
    print(str);
    if (str == null) return;

    selectedCity.value = str;
    cityId.value = str;

    // Clear related data when city changes
    addresses.clear();
    selectedAddress.value = null;
    showRoomId.value = '';

    // Load showroom units for the selected city
    if (cityId.value != null) {
      isLoading.value = true;
      var response = await DioClient.instance.getShowRoomUnites(cityId.value!);
      isLoading.value = false;

      if (response?.message == 'OK') {
        for (var element in response?.units ?? []) {
          addresses[element.id ?? ''] = element.address ?? '';
        }
      }
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length && index < base64Images.length) {
      images.removeAt(index);
      base64Images.removeAt(index);
    }
  }

  Future<void> onAddressSelected(String? str) async {
    print(str);
    if (str == null) return;

    selectedAddress.value = str;

    isLoading.value = true;
    karshenasResponse = await DioClient.instance
        .getAvailabeAccountManagers(selectedAddress.value ?? '');
    isLoading.value = false;

    if (karshenasResponse?.users != null) {
      for (var element in karshenasResponse!.users!) {
        if (element.name == 'به انتخاب سيستم') {
          karshenasList[element.id ?? ''] = (element.name ?? '');
          selectedKarshenas.value = element.id;
        } else {
          karshenasList[element.id!] =
              (element.name ?? "") + " " + (element.lastname ?? "");
        }
      }
    }
  }

  void onKarshenasSelected(String? str) {
    if (str == null) return;
    selectedKarshenas.value = str;
  }

  Future<void> submitRequest() async {
    if (selectedAddress.value == null || selectedKarshenas.value == null) {
      showToast(ToastState.INFO, 'لطفا مقادیر خواسته شده را تکمیل نمایید');
      return;
    }

    isLoading.value = true;
    try {
      await insertRequest();
      await requestTogetTarefe();
      // Navigate to next step if needed
      //step.value = SellPageStep.showTarefe;
    } catch (e) {
      showToast(ToastState.ERROR, 'خطا در ثبت درخواست');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestToGetTarefe() async {
    isLoading.value = true;
    update();

    print(carId.value); // Assuming carId is being used instead of _carId
    final response = await DioClient.instance
        .getExpertAmountResponse(id: carId.value.toString());

    isLoading.value = false;
    update();

    if (response == null) {
      showToast(ToastState.ERROR, 'خطا در دریافت تعرفه');
      return;
    }

    if (response.message == 'OK') {
      final expertAmount = response.salesOrder?.expertAmount;
      if (expertAmount == null) {
        showToast(ToastState.ERROR, 'تعرفه‌ای برای سفارش شما یافت نشد');
        return;
      }

      totalPrice.value = response.salesOrder?.orderAmount ?? "0";
      tarefe.value = expertAmount;
      step.value = SellPageStep.showTarefe;
    } else {
      showToast(ToastState.ERROR, 'خطا در دریافت تعرفه');
    }
  }

  String dotConvertor(Dot dot) {
    if (dot.color == AppColors.khatokhash) {
      return '2';
    }
    if (dot.color == AppColors.taviz) {
      return '4';
    }
    if (dot.color == AppColors.safkari) {
      return '1';
    }
    if (dot.color == AppColors.zarebekhorde) {
      return '0';
    }
    if (dot.color == AppColors.rangshode) {
      return '3';
    }

    return '0';
  }

  int image_width() => 434;

  int image_height() => 300;

  Future<void> insertRequest() async {
    print(timeId.value.replaceAll('+', ''));

    // Prepare Documents
    List<Documents> docs = [];
    for (int i = 0; i < images.length; i++) {
      final image = images[i];
      if (image == null) continue;
      final extension = image.name.split('.').last;
      final content = 'data:image/$extension;base64,${base64Images[i]}';

      docs.add(Documents(
        content: content,
        fileName: image.name,
        fileType: extension,
        index: i + 1,
      ));
    }

    // Prepare Dot Bodies
    List<Bodys> bodies = positions.map((dot) {
      return Bodys(
        x: dot.x.toInt().toString(),
        y: dot.y.toInt().toString(),
        t: dotConvertor(dot),
      );
    }).toList();

    // Prepare Body Detail
    Bodydetail bodydetail = Bodydetail(
      bodies: bodies,
      imageWidth: image_width().toString(),
      imageHeight: image_height().toString(),
    );

    isLoading.value = true;

    // Optional: update UI if needed
    update();

    final response = await DioClient.instance.insertOrderData(
      referredId: selectedAddress.value ?? '',
      accountManagerId: selectedKarshenas.value?.replaceAll('.', ''),
      isSwap: isSwap.value ? '1' : '0',
      commentSwap: swapCommentController.text,
      documents: docs.map((v) => v.toJson()).toList(),
      bodies: bodydetail.toJson(),
      amount: englishToPersian(amountController.text.replaceAll(',', ''))
          .replaceAll('٬', ''),
      comment: commentController.text,
      carId: carId.value.toString(),
      milageStatus: milageStatus.value == 0 ? 'NEW' : 'USED',
      IwillTakeCar: otherWillTakeCar.value,
      referredLastName: !otherWillTakeCar.value
          ? account?.lastName ?? ''
          : lastNameController.text,
      referredName:
          !otherWillTakeCar.value ? account?.name ?? '' : nameController.text,
      referredNationalId: !otherWillTakeCar.value
          ? account?.nationalId
          : englishToPersian(nationalCodeController.text),
      mileage: englishToPersian(kilometerController.text.replaceAll(',', ''))
              .replaceAll('٬', '')
              .isEmpty
          ? '0'
          : englishToPersian(kilometerController.text.replaceAll(',', ''))
              .replaceAll('٬', ''),
    );
    print(response?.toJson());
    print(response?.toJson());
    isLoading.value = false;
    update();

    if (response == null) {
      showToast(ToastState.ERROR, 'خطا در ثبت اطلاعات');
      return;
    }

    if (response.message == "OK") {
      final order = response.salesOrder;
      orderId.value = order?.id ?? '';
      date.value = order?.registerDate ?? '';
      factorNumber.value = order?.expertOrderId ?? '';
      orderNumber.value = order?.orderNumber ?? '';
      totalPrice.value = order?.orderAmount ?? '';
      discountPrice.value = '0';
      paidPrice.value = totalPrice.value;
      dargahAmount.value = paidPrice.value;
      var confRes =
          await DioClient.instance.confirmPayment(orderId: order?.id ?? '');
      if (confRes?.message == 'OK') {
        step.value = SellPageStep.showPaymentResult;
      } else {
        showToast(ToastState.ERROR, 'خطا در ثبت اطلاعات');
      }
    } else {
      showToast(ToastState.ERROR, 'خطا در ثبت اطلاعات');
    }
  }

  Future<void> requestTogetTarefe() async {
    // Implementation for getting tarefe from the server
    // Add your implementation here based on the original code
  }
}

class Documents {
  int? index;
  String? content;
  String? fileName;
  String? fileType;

  Documents({this.index, this.content, this.fileName, this.fileType});

  Documents.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    content = json['content'];
    fileName = json['fileName'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['content'] = this.content;
    data['fileName'] = this.fileName;
    data['fileType'] = this.fileType;
    return data;
  }
}

class Bodys {
  String? x;
  String? y;
  String? t;

  Bodys({this.x, this.y, this.t});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    data['t'] = this.t;
    return data;
  }
}

class Bodydetail {
  List<Bodys>? bodies;
  String? imageWidth;
  String? imageHeight;

  Bodydetail({this.bodies, this.imageWidth, this.imageHeight});

  Bodydetail.fromJson(Map<String, dynamic> json) {
    if (json['bodies'] != null) {
      bodies = [];
    }
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bodies != null) {
      data['bodies'] = bodies!.map((v) => v.toJson()).toList();
    }
    data['imageWidth'] = imageWidth;
    data['imageHeight'] = imageHeight;
    return data;
  }
}
