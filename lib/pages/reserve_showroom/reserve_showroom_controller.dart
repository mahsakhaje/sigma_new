// Controller
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
      location: const LatLng(Angle.degree(0), Angle.degree(0)), zoom: 2,);
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      _detailResponse.value = await DioClient.instance.getCarDetail(id: id);
      _getTimes.value = await DioClient.instance.getAvailebleTimeForShowRoom(
          id: detailResponse?.salesOrder?.showRoomId ?? '1');

      _populateTimes();
      _setupMapLocation();
    } catch (e) {
      Get.snackbar('خطا', 'خطا در بارگذاری اطلاعات');
    }
  }

  void _populateTimes() {
    times.clear();
    getTimes?.timespans?.forEach((element1) {
      element1.times?.forEach((element) {
        times[element1.id!] = element1.description!;
      });
    });
  }

  void _setupMapLocation() {
    _selectedLat.value =
        double.tryParse(detailResponse?.salesOrder?.showRoomLat ?? '0') ?? 0;
    _selectedLong.value =
        double.tryParse(detailResponse?.salesOrder?.showRoomLon ?? '0') ?? 0;

    mapController.zoom = 14;
    mapController.center = LatLng(Angle.degree(selectedLat), Angle.degree(selectedLong));
    markers.clear();
    markers.add(LatLng(Angle.degree(selectedLat), Angle.degree(selectedLong)));
  }

  void onTimeSelected(String? time) {
    _selectedTime.value = time ?? "";
    _selectedHour.value = null;
    hours.clear();
    karshenas.clear();
    _turn.value = 2;
    getTimes?.timespans?.forEach((element) {
      print(element.description);
      if (element.id == selectedTime) {
        _timeSpanId.value = element.id!;
      }
    });

    getTimes?.timespans?.forEach((element) {
      if (element.id == timeSpanId) {
        element.times?.forEach((element) {
          hours[element.id ?? ""] = element.description ?? '';
        });
      }
    });
  }

  void onHourSelected(String? hour) {
    _turn.value = 3;
    _selectedHour.value = hour ?? "";
    karshenas.clear();

    _populateKarshenas();
    _setDefaultKarshenas();
  }

  void _populateKarshenas() {
    getTimes?.timespans?.forEach((element) {
      if (element.id == timeSpanId) {
        element.times?.forEach((element) {
          if (element.id == selectedHour) {
            element.accountManagers?.forEach((manager) {
              if (manager.name == 'به انتخاب سيستم') {
                karshenas[manager.id ?? ''] = manager.name ?? '';
                _selectedKarshenas.value = manager.id;
              } else {
                String fullName =
                    "${manager.name ?? ''} ${manager.lastname ?? ''}";
                if (!karshenas.containsValue(fullName)) {
                  karshenas[manager.id ?? ""] = fullName;
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
        element.times?.forEach((element) {
          if (element.description == selectedHour) {
            element.accountManagers?.forEach((manager) {
              if (manager.id == selectedKarshenas) {
                _timeId.value = manager.id ?? "";
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
        element.times?.forEach((element) {
          if (element.description == selectedHour) {
            element.accountManagers?.forEach((manager) {
              if (manager.id == selectedKarshenas) {
                _timeId.value = manager.id ?? "";
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

      var response = await DioClient.instance.reserveShowRoom(
          salesOrderId: id,
          timespanCapacityId: _selectedKarshenas?.replaceAll('.', '') ?? '');
      print(response?.toJson());
      if (response != null && response.message == 'OK') {
        _showSuccessDialog(response);
        return;
      } else {
        showToast(
            ToastState.ERROR, response?.persianMessage ?? 'خطا در رزرو شوروم');
        return;
      }
    } catch (e) {
      //showToast(ToastState.ERROR, 'خطا در رزرو شوروم');
    } finally {
      _isLoading.value = false;
    }
  }

  void _showSuccessDialog(dynamic response) async{
  await  Get.dialog(
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
                        CustomText(
                            response?.reservation?.orderNumber ??
                                '',
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
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
