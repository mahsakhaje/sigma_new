// Controller
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/models/car_detail_response.dart';
import 'package:sigma/models/get_availeble_times.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReserveShowRoomController extends GetxController {
  final String id;

  ReserveShowRoomController({required this.id});

  late MapController mapController;
  final RxList<LatLng> markers = <LatLng>[].obs;

  // Observables
  final _getTimes = Rxn<GetAvailebleTimeResponse>();
  final _detailResponse = Rxn<CarDetailResponse>();
  final _isLoading = false.obs;
  final _turn = 1.obs;
  final _timeSpanId = ''.obs;
  final addresses = <String, dynamic>{}.obs;
  final _selectedLat = 0.0.obs;
  final _selectedLong = 0.0.obs;
  final _selectedAddress = Rxn<String>();
  final _timeId = ''.obs;
  final hours = <String, String>{}.obs;
  final karshenas = <String, String>{}.obs;
  final _karshenasId = ''.obs;
  final _selectedTime = Rxn<String>();
  final _selectedKarshenas = Rxn<String>();
  final _selectedHour = Rxn<String>();
  final times = <String, String>{}.obs;

  // Getters
  GetAvailebleTimeResponse? get getTimes => _getTimes.value;

  CarDetailResponse? get detailResponse => _detailResponse.value;

  bool get isLoading => _isLoading.value;

  int get turn => _turn.value;

  String get timeSpanId => _timeSpanId.value;

  double get selectedLat => _selectedLat.value;

  double get selectedLong => _selectedLong.value;

  String? get selectedAddress => _selectedAddress.value;

  String get timeId => _timeId.value;

  String get karshenasId => _karshenasId.value;

  String? get selectedTime => _selectedTime.value;

  String? get selectedKarshenas => _selectedKarshenas.value;

  String? get selectedHour => _selectedHour.value;

  @override
  void onInit() {
    super.onInit();
    mapController = MapController(
      location: const LatLng(Angle.degree(0), Angle.degree(0)),
      zoom: 2,
    );
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      _detailResponse.value = await DioClient.instance.getCarDetail(id: id);

      final showRoomId = detailResponse?.salesOrder?.showRoomId ?? '1';

      _getTimes.value =
          await DioClient.instance.getAvailebleTimeForShowRoom(id: showRoomId);

      _populateTimes();

      _setupMapLocation();
    } catch (e) {
      Get.snackbar('خطا', 'خطا در بارگذاری اطلاعات');
    }
  }

  void _populateTimes() {
    times.clear();
    getTimes?.timespans?.forEach((element1) {
      if (element1.id != null && element1.description != null) {
        times[element1.id!] = element1.description!;
      }
    });
  }

  Future<void> launchNavigation() async {
    var lat = _selectedLat.value;
    var lng = _selectedLong.value;

    if (lat == 0.0 && lng == 0.0) {
      showToast(ToastState.ERROR, 'موقعیت مکانی موجود نیست');
      return;
    }

    try {
      Uri uri;

      if (Platform.isIOS) {
        uri = Uri.parse("http://maps.apple.com/?q=$lat,$lng");
      } else {
        uri = Uri.parse("geo:$lat,$lng");
      }

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      showToast(ToastState.ERROR, 'امکان باز کردن نقشه وجود ندارد');
    }
  }

  void _setupMapLocation() {
    final lat = detailResponse?.salesOrder?.showRoomLat ?? '0';
    final lng = detailResponse?.salesOrder?.showRoomLon ?? '0';

    _selectedLat.value = double.tryParse(lat) ?? 0;
    _selectedLong.value = double.tryParse(lng) ?? 0;

    if (_selectedLat.value != 0.0 && _selectedLong.value != 0.0) {
      mapController.zoom = 14;
      mapController.center =
          LatLng(Angle.degree(selectedLat), Angle.degree(selectedLong));
      markers.clear();
      markers
          .add(LatLng(Angle.degree(selectedLat), Angle.degree(selectedLong)));
    } else {}
  }

  void onTimeSelected(String? time) {
    _selectedTime.value = time ?? "";
    _selectedHour.value = null;
    _selectedKarshenas.value = null;
    hours.clear();
    karshenas.clear();
    _turn.value = 2;

    getTimes?.timespans?.forEach((element) {
      if (element.id == selectedTime) {
        _timeSpanId.value = element.id!;
      }
    });

    getTimes?.timespans?.forEach((element) {
      if (element.id == timeSpanId) {
        element.times?.forEach((timeElement) {
          if (timeElement.id != null && timeElement.description != null) {
            hours[timeElement.id!] = timeElement.description!;
          }
        });
      }
    });
  }

  void onHourSelected(String? hour) {
    _turn.value = 3;
    _selectedHour.value = hour ?? "";
    _selectedKarshenas.value = null;
    karshenas.clear();

    _populateKarshenas();
    _setDefaultKarshenas();
  }

  void _populateKarshenas() {
    getTimes?.timespans?.forEach((element) {
      if (element.id == timeSpanId) {
        element.times?.forEach((timeElement) {
          if (timeElement.id == selectedHour) {
            timeElement.accountManagers?.forEach((manager) {
              if (manager.id != null && manager.name != null) {
                if (manager.name == 'به انتخاب سيستم') {
                  karshenas[manager.id!] = manager.name!;
                  _selectedKarshenas.value = manager.id;
                } else {
                  String fullName =
                      "${manager.name ?? ''} ${manager.lastname ?? ''}".trim();
                  if (!karshenas.containsValue(fullName)) {
                    karshenas[manager.id!] = fullName;
                  }
                }
              }
            });
          }
        });
      }
    });
  }

  void _setDefaultKarshenas() {
    getTimes?.timespans?.forEach((element) {
      if (element.id == timeSpanId) {
        element.times?.forEach((timeElement) {
          if (timeElement.id == selectedHour) {
            timeElement.accountManagers?.forEach((manager) {
              if (manager.id == selectedKarshenas && manager.id != null) {
                _timeId.value = manager.id!;
              }
            });
          }
        });
      }
    });
  }

  void onKarshenasSelected(String? karshenasId) {
    _turn.value = 4;
    _selectedKarshenas.value = karshenasId ?? "";

    getTimes?.timespans?.forEach((element) {
      if (element.id == timeSpanId) {
        element.times?.forEach((timeElement) {
          if (timeElement.id == selectedHour) {
            timeElement.accountManagers?.forEach((manager) {
              if (manager.id == selectedKarshenas && manager.id != null) {
                _timeId.value = manager.id!;
              }
            });
          }
        });
      }
    });
  }

  Future<void> reserveShowRoom() async {
    try {
      _isLoading.value = true;

      final capacityId = _selectedKarshenas.value?.replaceAll('.', '') ?? '';

      var response = await DioClient.instance
          .reserveShowRoom(salesOrderId: id, timespanCapacityId: capacityId);

      if (response != null && response.message == 'OK') {
        _showSuccessDialog(response);
        return;
      } else {
        showToast(
            ToastState.ERROR, response?.persianMessage ?? 'خطا در رزرو شوروم');
        return;
      }
    } catch (e) {
      showToast(ToastState.ERROR, 'خطا در رزرو شوروم');
    } finally {
      _isLoading.value = false;
    }
  }

  void _showSuccessDialog(dynamic response) async {
    await Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
                'تغییرات مربوط به این خودرو به شماره همراه شما اطلاع داده خواهد شد.',
                isRtl: true,
                size: 16,
                color: Colors.black87),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        kIsWeb
                            ? SizedBox()
                            : InkWell(
                                onTap: () => _copyOrderNumber(response),
                                child: Icon(Icons.copy, color: Colors.black87),
                              ),
                        SizedBox(width: 8),
                        CustomText(response?.reservation?.orderNumber ?? '',
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ],
                    ),
                    CustomText('کد رهگیری:',
                        isRtl: true,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)
                  ],
                ),
              ),
            ),
            SizedBox(height: 26),
            ConfirmButton(
              () {
                Get.back();
                Get.back();
              },
              'بازگشت',
              color: AppColors.blue,
              txtColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  void _copyOrderNumber(dynamic response) {
    Clipboard.setData(
        ClipboardData(text: response?.reservation?.orderNumber ?? ''));
    showToast(ToastState.SUCCESS, 'کدرهگیری کپی شد');
  }
}
