import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:universal_platform/universal_platform.dart';

import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/storage_helper.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/AllCitiesResponse.dart';
import 'package:sigma/models/AllProviencesResponse.dart';
import 'package:sigma/models/ChassiInquiry_model.dart';
import 'package:sigma/models/PriceItems%20Response.dart';
import 'package:sigma/models/UpdateModel.dart';
import 'package:sigma/models/about_us_model.dart';
import 'package:sigma/models/account_announcment_response.dart';
import 'package:sigma/models/add_new_car_response.dart';
import 'package:sigma/models/all_cars_json_model.dart';
import 'package:sigma/models/application_info_model.dart';
import 'package:sigma/models/available_account_manager.dart';
import 'package:sigma/models/banners_response.dart';
import 'package:sigma/models/base_model.dart';
import 'package:sigma/models/blog_response_model.dart';
import 'package:sigma/models/calculate_loan_payments_response.dart';
import 'package:sigma/models/cancel_response.dart';
import 'package:sigma/models/car_detail_response.dart';
import 'package:sigma/models/car_info_response.dart';
import 'package:sigma/models/car_type_equipment_model.dart';
import 'package:sigma/models/car_type_spec_type.dart';
import 'package:sigma/models/change_price_model.dart';
import 'package:sigma/models/color_response_model.dart';
import 'package:sigma/models/confirm_payment_model.dart';
import 'package:sigma/models/contact_us_model.dart';
import 'package:sigma/models/discount_response.dart';
import 'package:sigma/models/estimate_response.dart';
import 'package:sigma/models/expert_order_model.dart';
import 'package:sigma/models/experties.dart';
import 'package:sigma/models/get_availeble_times.dart';
import 'package:sigma/models/get_loan_duration.dart';
import 'package:sigma/models/insert_purchase_model.dart';
import 'package:sigma/models/login_response_model.dart';
import 'package:sigma/models/mana_prices_response.dart';
import 'package:sigma/models/my_cars_model.dart';
import 'package:sigma/models/my_purchase_order_response.dart';
import 'package:sigma/models/my_reservation_model.dart';
import 'package:sigma/models/my_sell_cars_response.dart';
import 'package:sigma/models/notif_count_response.dart';
import 'package:sigma/models/notif_list_response.dart';
import 'package:sigma/models/online_pay_model.dart';
import 'package:sigma/models/payments_model.dart';
import 'package:sigma/models/published_transaction_response.dart';
import 'package:sigma/models/questions_model.dart';
import 'package:sigma/models/reserve_show_room_model.dart';
import 'package:sigma/models/rules_model.dart';
import 'package:sigma/models/showrooms_unites_model.dart';
import 'package:sigma/models/showroos_cities_response.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';
import 'package:sigma/models/stocks_model.dart';
import 'package:sigma/models/suggestiontypes_model.dart';
import 'package:sigma/models/telephone_model.dart';
import 'package:sigma/models/tracking_sales_model.dart';
import 'package:sigma/models/user_info_model.dart';
import '../models/get_expert_amount_response.dart';
import '../models/insert_order_response.dart';
import '../models/update_insert_order_response.dart';

class DioClient {
  static final DioClient instance = DioClient._privateConstructor();

  final Dio _dio;

  DioClient._privateConstructor()
      : _dio = Dio(
          BaseOptions(
            baseUrl: URLs.BaseUrl,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            validateStatus: (status) => status! < 500,
            sendTimeout: const Duration(seconds: 20),
          ),
        ) {
    if (!kIsWeb) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback = (_, __, ___) => true;
        return client;
      };
    }
  }

  String _token() {
    String? token = StorageHelper().getShortToken();
    return token ?? "";
  }

  /// Builds the standard request body, merging caller-supplied [extra] fields.
  Future<Map<String, dynamic>> _buildBody(Map<String, dynamic> extra) async {
    return {
      'version': await getVersion(),
      ...extra,
    };
  }

  /// POST wrapper — handles auth header, byte vs JSON response, and errors.
  Future<Response?> _post(
    String url,
    Map<String, dynamic> data, {
    bool asBytes = false,
  }) async {
    try{

    if (JwtDecoder.isExpired(_token() ?? '')) {
      Get.toNamed(RouteName.auth);
    }}catch(e){
      print(e);
    }
    try {

      var response = await _dio.post(
        url,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Authorization':
                url.contains('public') || _token().isEmpty ? 'null' : _token()
          },
          responseType: asBytes ? ResponseType.bytes : ResponseType.json,
        ),
      );
      return response;
    } catch (e) {
      debugPrint('POST $url error: $e');
      return null;
    }
  }

  /// Parses a 200 response with [fromJson], shows an error toast otherwise.
  T? _parse<T>(Response? response, T Function(Map<String, dynamic>) fromJson) {

    if (response?.statusCode != 200) return null;
    _showErrorIfNeeded(response!.data as Map<String, dynamic>);
    return fromJson(response.data as Map<String, dynamic>);
  }

  void _showErrorIfNeeded(Map<String, dynamic> data) {
    if ((data['status'] as int? ?? 0) != 0) {
      showToast(ToastState.ERROR, data['persianMessage']);
    }
  }

  Future<LoginResponse?> _fetchAppToken() async {
    final credentials = UniversalPlatform.isAndroid
        ? {'username': 'APP_ANDROID', 'password': 'aPP@nd'}
        : {'username': 'APP_PWA', 'password': r'App$wa'};

    final response =
        await _dio.post(URLs.TokenUrl, data: jsonEncode(credentials));
    if (response.statusCode == 200) {
      final loginResponse =
          LoginResponse.fromJson(response.data as Map<String, dynamic>);
      if (loginResponse.token != null) {
        StorageHelper().setToken(loginResponse.token!);
      }
      return loginResponse;
    }
    return null;
  }

  Future<LoginResponse?> sendOTP({required String cellNumber}) async {
    final response = await _post(URLs.SendOTPUrl, {
      'account': {'cellNumber': cellNumber.toEnglishDigit()},
    });
    return _parse(response, LoginResponse.fromJson);
  }

  Future<LoginResponse?> confirmOTP({
    required String cellNumber,
    required String password,
  }) async {
    final response = await _post(URLs.ConfirmOTPUrl, {
      'account': {
        'cellNumber': cellNumber.toEnglishDigit(),
        'password': password,
      },
    });
    return _parse(response, LoginResponse.fromJson);
  }

  Future<LoginResponse?> login(String cellNumber, String password) async {
    final body = await _buildBody({
      'account': {
        'cellNumber': cellNumber.toEnglishDigit(),
        'password': password,
      },
    });
    final response = await _post(URLs.LoginUrl, body);
    return _parse(response, LoginResponse.fromJson);
  }

  Future<BaseResponse?> register({
    required String name,
    required String lastName,
    required String orgName,
    required String gender,
    required String email,
    required String orgNationalId,
    required String geoNameId,
    required String nationalId,
    required String password,
    required String cellNumber,
    required bool isReal,
    required String referralCode,
  }) async {
    final body = await _buildBody({
      'account': {
        'cellNumber': cellNumber.toEnglishDigit(),
        'nationalId': nationalId.toEnglishDigit(),
        'password': password.toEnglishDigit(),
        'name': name,
        'sex': gender,
        'email': email,
        'geoNameId': geoNameId,
        'referralCode': referralCode,
        'orgNationalId': orgNationalId.toEnglishDigit(),
        'orgName': orgName,
        'lastName': lastName,
        'isReal': isReal ? '1' : '0',
      },
    });
    final response = await _post(URLs.RegisterUrl, body);
    return _parse(response, BaseResponse.fromJson);
  }

  Future<LoginResponse?> confirmRegister({
    required String code,
    required String cellNumber,
    required String referralCode,
  }) async {
    final body = await _buildBody({
      'account': {
        'cellNumber': cellNumber.toEnglishDigit(),
        'password': code.toEnglishDigit(),
        'referralCode': referralCode.toEnglishDigit(),
      },
    });
    final response = await _post(URLs.ConfirmRegisterUrl, body);
    return _parse(response, LoginResponse.fromJson);
  }

  Future<LoginResponse?> forgetPassword({required String cellNumber}) async {
    final body = await _buildBody({
      'account': {'cellNumber': cellNumber.toEnglishDigit()},
    });
    final response = await _post(URLs.ResetPasswordUrl, body);
    return _parse(response, LoginResponse.fromJson);
  }

  Future<LoginResponse?> verifyResetPassword({
    required String password,
    required String cellNumber,
  }) async {
    final body = await _buildBody({
      'account': {
        'cellNumber': cellNumber.toEnglishDigit(),
        'password': password.toEnglishDigit(),
      },
    });
    final response = await _post(URLs.VerifyResetPasswordUrl, body);
    return _parse(response, LoginResponse.fromJson);
  }

  Future<LoginResponse?> confirmNewPassword({
    required String newPassword,
    required String cellNumber,
    required String code,
  }) async {
    final body = await _buildBody({
      'cellNumber': cellNumber.toEnglishDigit(),
      'verificationCode': code.toEnglishDigit(),
      'newPassword': newPassword.toEnglishDigit(),
    });
    final response = await _post(URLs.ConfirmNewPasswordUrl, body);
    return _parse(response, LoginResponse.fromJson);
  }

  Future<UserInfoResponse?> getUserInfo() async {
    final response = await _post(URLs.GetUserInfoUrl, await _buildBody({}));
    return _parse(response, UserInfoResponse.fromJson);
  }

  Future<BaseResponse?> updateUserInfo({
    required String name,
    required String lastName,
    required String cellNumber,
    required String nationalId,
    required bool isReal,
    String? address,
    String? gender,
    String? orgNationalId,
    String? orgName,
    String? email,
    String? postalCode,
    String? geoNameId,
  }) async {
    final body = await _buildBody({
      'account': {
        'name': name,
        'lastName': lastName,
        'cellNumber': cellNumber.toEnglishDigit(),
        'nationalId': nationalId.toEnglishDigit(),
        'isReal': isReal ? '1' : '0',
        'sex': gender,
        'email': email,
        'geoNameId': geoNameId,
        'orgName': orgName,
        'orgNationalId': orgNationalId,
        'accountAddress': address?.toEnglishDigit(),
        'postalCode': postalCode?.toEnglishDigit(),
      },
    });
    final response = await _post(URLs.UpdateUserInfoUrl, body);
    return _parse(response, BaseResponse.fromJson);
  }

  Future<NotifCountResponse?> getNotifCount() async {
    final response =
        await _post(URLs.GetAppAccountNotifsCountUrl, await _buildBody({}));
    return _parse(response, NotifCountResponse.fromJson);
  }

  Future<NotifListResponse?> getNotifList() async {
    final response = await _post(URLs.GetNotifsListUrl, await _buildBody({}));
    return _parse(response, NotifListResponse.fromJson);
  }

  Future<LoginResponse?> setSeenNotifs() async {
    final response = await _post(URLs.SeenNotifsUrl, await _buildBody({}));
    return _parse(response, LoginResponse.fromJson);
  }

  Future<MyCarsResponse?> getMyCars({
    String query = '',
    required int pn,
    required int pl,
  }) async {
    final body = await _buildBody({
      'car': {'chassisNumber': query},
      'pn': pn.toString(),
      'pl': pl.toString(),
    });
    final response = await _post(URLs.GetMyCarsUrl, body);
    return _parse(response, MyCarsResponse.fromJson);
  }

  Future<MySellCarsResponse?> getCars() async {
    final body = await _buildBody({'pn': '1', 'pl': '100'});
    final response = await _post(URLs.GetMyCarsUrl, body);
    return _parse(response, MySellCarsResponse.fromJson);
  }

  Future<AddNewCarResponse?> addNewCar({
    required String carTypeId,
    required String chassisNumber,
    required String colorId,
    required String manufactureYearId,
    required String trimColorId,
  }) async {
    final body = await _buildBody({
      'car': {
        'id': '',
        'carTypeId': carTypeId,
        'chassisNumber': chassisNumber.toEnglishDigit(),
        'colorId': colorId,
        'trimColorId': trimColorId,
        'manufactureYearId': manufactureYearId,
      },
    });
    final response = await _post(URLs.AddNewCardUrl, body);
    return _parse(response, AddNewCarResponse.fromJson);
  }

  Future<AddNewCarResponse?> updateCar({
    required String id,
    required String carTypeId,
    required String chassisNumber,
    required String colorId,
    required String manufactureYearId,
    required String trimColorId,
  }) async {
    final body = await _buildBody({
      'car': {
        'id': id,
        'carTypeId': carTypeId,
        'chassisNumber': chassisNumber.toEnglishDigit(),
        'colorId': colorId,
        'trimColorId': trimColorId,
        'manufactureYearId': manufactureYearId,
      },
    });
    final response = await _post(URLs.UpdateCardUrl, body);
    return _parse(response, AddNewCarResponse.fromJson);
  }

  Future<AddNewCarResponse?> deleteCar({required String id}) async {
    final body = await _buildBody({
      'car': {'id': id}
    });
    final response = await _post(URLs.DeleteCarUrl, body);
    return _parse(response, AddNewCarResponse.fromJson);
  }

  Future<CarDetailResponse?> getCarDetail({required String id}) async {
    final body = await _buildBody({'orderId': id});
    final response = await _post(URLs.GetSalesOrderInfoUrl, body);
    return _parse(response, CarDetailResponse.fromJson);
  }

  Future<CarInfoResponse?> getCarInfo({required String id}) async {
    final body = await _buildBody({
      'car': {'id': id}
    });
    final response = await _post(URLs.GetCarInfoUrl, body);
    return _parse(response, CarInfoResponse.fromJson);
  }

  Future<bool> checkChassisNumber(String chassisNumber) async {
    final body =
        await _buildBody({'chassisNumber': chassisNumber.toEnglishDigit()});
    final response = await _post(URLs.GetIsValidChassisNumberUrl, body);
    return response?.statusCode == 200 && response?.data['message'] == 'OK';
  }

  Future<ChassiInquiryResponse?> getInquiryChassisNumber({
    required String chassisNumber,
  }) async {
    final body =
        await _buildBody({'chassisNumber': chassisNumber.toEnglishDigit()});
    final response = await _post(URLs.GetInquiryChassisNumberUrl, body);
    return _parse(response, ChassiInquiryResponse.fromJson);
  }

  Future<BaseResponse?> hasActiveOrderWithChassisNumber(String id) async {
    final body = await _buildBody({
      'car': {'id': id}
    });
    final response =
        await _post(URLs.GetHasActiveOrderWithChassisNumberUrl, body);
    return _parse(response, BaseResponse.fromJson);
  }

  Future<AllCarsJsonModel?> getAllCarsJson() async {
    final response = await _post(URLs.AllCarsUrl, {'data-raw': '{}'});
    return _parse(response, AllCarsJsonModel.fromJson);
  }

  Future<SigmaSalesOrderResponse?> getSalesOrdersWithFilter({
    String? brandId,
    String? carModelId,
    String? carTypeId,
    String? carTypeIds,
    String? colorId,
    String? cityId,
    String? state,
    String? cityIds,
    String? fromAmount,
    String? fromYear,
    String? toAmount,
    String? toYear,
    String? trimColorId,
    required int pn,
    required int pl,
  }) async {
    final body = await _buildBody({
      'brandIds': brandId ?? '',
      'carModelId': carModelId ?? '',
      'carModelIds': carModelId ?? '',
      'carTypeIds': carTypeIds ?? '',
      'colorId': colorId ?? '',
      'cityId': cityId ?? '',
      'cityIds': cityIds ?? '',
      'carState': state ?? '',
      'fromAmount': fromAmount,
      'fromYear': fromYear,
      'toAmount': toAmount,
      'toYear': toYear,
      'trimColorId': trimColorId,
      'pn': pn.toString(),
      'pl': pl.toString(),
    });
    final response = await _post(URLs.GetSalesOrdersWithFilterUrl, body);
    return _parse(response, SigmaSalesOrderResponse.fromJson);
  }

  Future<SigmaSalesOrderResponse?> getAccountsSalesOrder({
    required int pn,
    required int pl,
  }) async {
    final body = await _buildBody({'pn': pn.toString(), 'pl': pl.toString()});
    final response = await _post(URLs.GetAccountsSalesOrderUrl, body);
    return _parse(response, SigmaSalesOrderResponse.fromJson);
  }

  Future<SigmaSalesOrderResponse?> getFavourites() async {
    final response = await _post(URLs.FavouritesUrl, await _buildBody({}));
    return _parse(response, SigmaSalesOrderResponse.fromJson);
  }

  Future<BaseResponse?> changeLike({required String id}) async {
    final body = await _buildBody({
      'salesOrder': {'id': id}
    });
    final response = await _post(URLs.ChangeLikeUrl, body);
    return _parse(response, BaseResponse.fromJson);
  }

  Future<TrackingSalesOrderResponse?> trackSalesOrder(
      {required String id}) async {
    final body = await _buildBody({
      'salesOrder': {'id': id}
    });
    final response = await _post(URLs.TrackingSalesOrderUrl, body);
    return _parse(response, TrackingSalesOrderResponse.fromJson);
  }

  Future<InsertOrderResponse?> insertOrderData({
    required String carId,
    required String milageStatus,
    required String mileage,
    required String comment,
    required String referredId,
    required String amount,
    required bool iwillTakeCar,
    required String? referredName,
    required String? referredLastName,
    required String isSwap,
    required String commentSwap,
    required String? accountManagerId,
    required String? referredNationalId,
    required Map<String, dynamic> bodies,
    required List<Map<String, dynamic>> documents,
  }) async {
    final body = await _buildBody({
      'salesOrder': {
        'carId': carId,
        'comment': comment.toEnglishDigit(),
        'declaredAmount': amount.toEnglishDigit(),
        'mileage': mileage.toEnglishDigit(),
        'mileageState': milageStatus,
        'documents': documents,
        'carSwap': isSwap,
        'carSwapComment': commentSwap,
        'accountManagerId': accountManagerId,
        'referredId': referredId,
        'referred': iwillTakeCar ? '0' : '1',
        'referredName': referredName,
        'referredLastName': referredLastName,
        'referredNationalId': referredNationalId?.toEnglishDigit(),
        'bodyDetails': bodies,
      },
    });
    final response = await _post(URLs.InsertOrderUrl, body);
    return _parse(response, InsertOrderResponse.fromJson);
  }

  Future<UpdateInsertOrderResponse?> insertPhotos({
    required InsertImageBody body,
  }) async {
    final response = await _post(
      '/salesorders/updateSalesOrderWithDocuments',
      body.toJson(),
    );
    return _parse(response, UpdateInsertOrderResponse.fromJson);
  }

  Future<BaseResponse?> cancelOrder(
    String id,
    String reasonId,
    String description,
  ) async {
    final body = await _buildBody({
      'orderId': id,
      'reasonId': reasonId,
      'description': description,
    });
    final response = await _post(URLs.CancelOrdersUrl, body);
    return _parse(response, BaseResponse.fromJson);
  }

  Future<CancelReasonResponse?> getCancelReasons() async {
    final response = await _post(URLs.CancelReasonUrl, await _buildBody({}));
    return _parse(response, CancelReasonResponse.fromJson);
  }

  Future<PublishedTransactionsResponse?> getPublishedTransactions({
    required int pn,
    required int pl,
  }) async {
    final body = await _buildBody({'pn': pn.toString(), 'pl': pl.toString()});
    final response = await _post(URLs.PublishedTransactionsUrl, body);
    return _parse(response, PublishedTransactionsResponse.fromJson);
  }

  Future<InsertPurchaseOrderResponse?> insertPurchaseOrder({
    required String brandId,
    required String budget,
    required String carModelId,
    required String carTypeId,
    required String colorId,
    required String cityId,
    required String fromManufactureYear,
    required String fromMileage,
    required String toManufactureYear,
    required String toMileage,
    required String trimColorId,
    required String similarItems,
    required String isSwap,
    required String wantsLoan,
    required String commentSwap,
  }) async {
    final body = await _buildBody({
      'purchaseOrder': {
        'brandId': brandId,
        'cityId': cityId,
        'budget': budget.toEnglishDigit(),
        'carModelId': carModelId,
        'carTypeId': carTypeId,
        'colorId': colorId,
        'trimColorId': trimColorId,
        'similarItems': similarItems,
        'carSwap': isSwap,
        'wantsLoan': wantsLoan,
        'carSwapComment': commentSwap,
        'fromManufactureYear': fromManufactureYear,
        'toManufactureYear': toManufactureYear,
        'fromMileage': fromMileage,
        'toMileage': toMileage,
      },
    });
    final response = await _post(URLs.InsertPurchaseOrderUrl, body);
    return _parse(response, InsertPurchaseOrderResponse.fromJson);
  }

  Future<MyBuyOrdersResponse?> getMyPurchaseOrders({
    required int pn,
    required int pl,
  }) async {
    final body = await _buildBody({'pn': pn.toString(), 'pl': pl.toString()});
    final response = await _post(URLs.GetPurchaseOrderUrl, body);
    return _parse(response, MyBuyOrdersResponse.fromJson);
  }

  Future<MyExpertOrdersResponse?> getMyExpertOrders({
    required int pn,
    required int pl,
  }) async {
    final body = await _buildBody({'pn': pn.toString(), 'pl': pl.toString()});
    final response = await _post(URLs.GetExpertOrderUrl, body);
    return _parse(response, MyExpertOrdersResponse.fromJson);
  }

  Future<GetExpertAmountResponse?> getExpertAmount(
      {required String carId}) async {
    final body = await _buildBody({
      'salesOrder': {'carId': carId}
    });
    final response = await _post('/salesorders/getOrderAmount', body);
    return _parse(response, GetExpertAmountResponse.fromJson);
  }

  Future<ExpertiseResponse?> showExpertSummary(String id) async {
    final body = await _buildBody({
      'salesOrder': {'id': id}
    });
    final response = await _post(URLs.GetExpertSummaryUrl, body);
    return _parse(response, ExpertiseResponse.fromJson);
  }

  Future<PaymentsResponse?> getPayments() async {
    final body = await _buildBody({'pn': '1', 'pl': '100'});
    final response = await _post(URLs.GetMyPaymentssUrl, body);
    return _parse(response, PaymentsResponse.fromJson);
  }

  Future<ConfirmPaymentResponse?> confirmPayment(
      {required String orderId}) async {
    final body = await _buildBody({
      'orderId': orderId,
      'discountCode': '',
      'payType': 'CREDIT',
    });
    final response = await _post(URLs.ConfirmPaymentUrl, body);
    return _parse(response, ConfirmPaymentResponse.fromJson);
  }

  Future<DiscountResponse?> calculateDiscount(
    String orderId,
    String discountCode,
  ) async {
    final body = await _buildBody({
      'orderId': orderId,
      'discountCode': discountCode,
    });
    final response = await _post(URLs.CalculateDiscountAmountUrl, body);
    return _parse(response, DiscountResponse.fromJson);
  }

  Future<OnlinePayResponse?> payOnline({
    required String orderId,
    required String discountCode,
    required String useCredit,
    required String payType,
  }) async {
    final String successUrl, failureUrl;

    if (UniversalPlatform.isAndroid) {
      successUrl = URLs.BankCallBackSuccessUrl;
      failureUrl = URLs.BankCallBackFailureUrl;
    } else if (!kIsWeb) {
      successUrl = URLs.IosBankCallBackSuccessUrl;
      failureUrl = URLs.IosBankCallBackFailureUrl;
    } else {
      successUrl = URLs.PWASuccess;
      failureUrl = URLs.PWAError;
    }

    final body = await _buildBody({
      'orderId': orderId,
      'discountCode': discountCode.toEnglishDigit(),
      'payType': payType,
      'useCredit': useCredit,
      'callBackUrlSuccess': successUrl,
      'callBackUrlFailure': failureUrl,
    });
    final response = await _post(URLs.OnlinePaymentUrl, body);
    return _parse(response, OnlinePayResponse.fromJson);
  }

  Future<MyReservationsResponse?> getMyReservations({
    required int pn,
    required int pl,
  }) async {
    final body = await _buildBody({'pn': pn.toString(), 'pl': pl.toString()});
    final response = await _post(URLs.GetMyReservationsUrl, body);
    return _parse(response, MyReservationsResponse.fromJson);
  }

  Future<GetAvailebleTimeResponse?> getAvailableTimesForShowRoom({
    required String unitId,
  }) async {
    final body = await _buildBody({
      'unit': {'id': unitId}
    });
    final response = await _post('${URLs.GetAvailebleTimeUrl}', body);
    return _parse(response, GetAvailebleTimeResponse.fromJson);
  }

  Future<ReserveShowRoomResponse?> reserveShowRoom({
    required String salesOrderId,
    required String timespanCapacityId,
  }) async {
    final body = await _buildBody({
      'reservation': {
        'salesOrderId': salesOrderId,
        'timespanCapacityId': timespanCapacityId,
      },
    });
    final response = await _post(URLs.ReservationForShowRoomUrl, body);
    return _parse(response, ReserveShowRoomResponse.fromJson);
  }

  Future<BaseResponse?> cancelShowRoom({required String id}) async {
    final body = await _buildBody({
      'reservation': {'id': id}
    });
    final response = await _post(URLs.CancelShowroomUrl, body);
    return _parse(response, BaseResponse.fromJson);
  }

  Future<ShowroomsUniteResponse?> getShowRoomUnites(String geoNameId) async {
    final body = await _buildBody({
      'unit': {'geoNameId': geoNameId}
    });
    final response = await _post(URLs.GetShowRoomsUnitesUrl, body);
    return _parse(response, ShowroomsUniteResponse.fromJson);
  }

  Future<ShowroomsCitiesResponse?> getShowroomCities() async {
    final response =
        await _post(URLs.GetAvailableCitiesUrl, await _buildBody({}));
    return _parse(response, ShowroomsCitiesResponse.fromJson);
  }

  Future<AvailableAccountManagersResponse?> getAvailableAccountManagers(
      String unitId) async {
    final body = await _buildBody({
      'unit': {'id': unitId},
      'pn': '1',
      'pl': '1000',
    });
    final response = await _post(URLs.GetAvailableAccountManagersUrl, body);
    return _parse(response, AvailableAccountManagersResponse.fromJson);
  }

  Future<String?> getExpertReport(String id) => _downloadBytesReport(
      URLs.GetExpertReportUrl,
      {
        'salesOrder': {'id': id}
      },
      fileName: 'expert_report_$id');

  Future<String?> getExpertReportInCarDetail(String id) => _downloadBytesReport(
      URLs.GetExpertDownloadUrl,
      {
        'salesOrder': {'id': id}
      },
      fileName: 'expert_report_$id');

  Future<String?> getExpertReportInTracking(String id) => _downloadBytesReport(
      URLs.ExpertOrderPrintUrl,
      {
        'expertOrder': {'id': id}
      },
      fileName: id);

  Future<String?> getContractReportInTracking(String orderNumber) =>
      _downloadBytesReport(
          URLs.ContractPrintUrl,
          {
            'salesOrder': {'orderNumber': orderNumber}
          },
          fileName: orderNumber);

  Future<String?> _downloadBytesReport(
    String url,
    Map<String, dynamic> extra, {
    required String fileName,
  }) async {
    final body = await _buildBody(extra);
    final response = await _post(url, body, asBytes: true);
    if (response?.statusCode != 200 || response?.data == null) return null;

    // if (kIsWeb) {
    //   return FileSaver.instance.saveFile(
    //     name: fileName,
    //     bytes: response!.data!! as List<int>,
    //     ext: 'pdf',
    //     mimeType: MimeType.pdf,
    //   );
    // }
    final uniqueName = '$fileName${Random.secure().nextInt(10000)}';
    return saveFileToDownloads(uniqueName, response!.data);
  }

  Future<String?> downloadFileFromUrl(String url, String fileName) async {
    try {
      final response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200 && response.data != null) {
        return saveFileToDownloads(
          '${fileName}_${DateTime.now().millisecondsSinceEpoch}',
          response.data ?? [],
        );
      }
    } catch (e) {
      debugPrint('Error downloading file: $e');
    }
    return null;
  }

  Future<GetLoanDurationResponse?> getLoanDuration() async {
    final response =
        await _post(URLs.GetLoanDurationsUrl, await _buildBody({}));
    return _parse(response, GetLoanDurationResponse.fromJson);
  }

  Future<GetLoanPaymentResponse?> calculateLoanPayment(
    String amount,
    String loanDurationId,
  ) async {
    final body = await _buildBody({
      'amount': amount,
      'loanDurationId': loanDurationId,
    });
    final response = await _post(URLs.GetCalculateLoanPaymentsUrl, body);
    return _parse(response, GetLoanPaymentResponse.fromJson);
  }

  Future<ChangePriceResponse?> getPriceChange(
      String carTypeId, String year) async {
    final body = await _buildBody({'carTypeId': carTypeId, 'year': year});
    final response = await _post(URLs.GetChangePriceReportUrl, body);
    return _parse(response, ChangePriceResponse.fromJson);
  }

  Future<EstimateResponse?> estimatePrice({
    required String carTypeId,
    required String colorId,
    required String yearId,
    required String mileage,
    required List<String> itemValueIds,
  }) async {
    final body = await _buildBody({
      'carTypeId': carTypeId,
      'colorId': colorId,
      'yearId': yearId,
      'mileage': mileage.toEnglishDigit(),
      'itemValueIds': itemValueIds,
    });
    final response = await _post(URLs.EstimateUrl, body);
    return _parse(response, EstimateResponse.fromJson);
  }

  Future<PriceItemsResponse?> getPriceItems() async {
    final response =
        await _post(URLs.EstimatePriceItemsUrl, await _buildBody({}));
    return _parse(response, PriceItemsResponse.fromJson);
  }

  Future<ManaPricesResponse?> getManaPrices() async {
    final body = await _buildBody({'pl': '50'});
    final response = await _post(URLs.ManaPricesUrl, body);
    return _parse(response, ManaPricesResponse.fromJson);
  }

  Future<ManaPricesResponse?> getManaTechnicalPrices() async {
    final body = await _buildBody({'pl': '50'});
    final response = await _post(URLs.AllManaPricesUrl, body);
    return _parse(response, ManaPricesResponse.fromJson);
  }

  Future<BannersResponse?> getBanners() async {
    final response =
        await _post(URLs.GetApplicationBannersUrl, await _buildBody({}));
    return _parse(response, BannersResponse.fromJson);
  }

  Future<BlogResponse?> getBlogs({required int pn, required int pl}) async {
    final body = await _buildBody({'pn': pn.toString(), 'pl': pl.toString()});
    final response = await _post(URLs.BlogsUrl, body);
    return _parse(response, BlogResponse.fromJson);
  }

  Future<QuestionsResponse?> getAllQuestions() async {
    final response =
        await _post(URLs.GetAllFaqContentsUrl, await _buildBody({}));
    return _parse(response, QuestionsResponse.fromJson);
  }

  Future<AboutUsModel?> getAboutUs() async {
    final response =
        await _post(URLs.GetAboutUsContentUrl, await _buildBody({}));
    return _parse(response, AboutUsModel.fromJson);
  }

  Future<ContactUsResponse?> getContactUs() async {
    final response =
        await _post(URLs.GetContactUsContentUrl, await _buildBody({}));
    return _parse(response, ContactUsResponse.fromJson);
  }

  Future<TelephoneResponse?> getSupportTelephone() async {
    final response =
        await _post(URLs.GetSupportTelephoneUrl, await _buildBody({}));
    return _parse(response, TelephoneResponse.fromJson);
  }

  Future<RulesResponse?> getRules() async {
    final response =
        await _post(URLs.GetRegistrationRulesUrl, await _buildBody({}));
    return _parse(response, RulesResponse.fromJson);
  }

  Future<RulesResponse?> getPrivacyRules() async {
    final response = await _post(URLs.GetPrivacyRulesUrl, await _buildBody({}));
    return _parse(response, RulesResponse.fromJson);
  }

  Future<SuggestionTypesResponse?> getSuggestionTypes() async {
    final body = await _buildBody({'pn': '1', 'pl': '1000'});
    final response = await _post(URLs.GetSuggestionTypesUrl, body);
    return _parse(response, SuggestionTypesResponse.fromJson);
  }

  Future<BaseResponse?> insertSuggestion({
    required String id,
    required String comment,
  }) async {
    final body = await _buildBody({
      'suggestion': {'typeId': id, 'comment': comment},
    });
    final response = await _post(URLs.GetInsertSuggestionUrl, body);
    return _parse(response, BaseResponse.fromJson);
  }

  Future<ColorResponse?> getColors() async {
    final response = await _post(URLs.ColorsUrl, await _buildBody({}));
    return _parse(response, ColorResponse.fromJson);
  }

  Future<AllProvincesResponse?> getProvinces() async {
    final body = await _buildBody({'pn': '1', 'pl': '10000'});
    final response = await _post(URLs.GetAllProvincesUrl, body);
    return _parse(response, AllProvincesResponse.fromJson);
  }

  Future<AllCitiesResponse?> getCities(String provinceId) async {
    final body = await _buildBody({
      'parentId': provinceId,
      'pn': '1',
      'pl': '10000',
    });
    final response = await _post(URLs.GetProvinceCitiesUrl, body);
    return _parse(response, AllCitiesResponse.fromJson);
  }

  Future<StocksResponse?> getStocks(
    String total, {
    String? brandId,
    String? carModelId,
    String? carTypeId,
    String? manufactureYearId,
    String? mileageState,
  }) async {
    final body = await _buildBody({
      'pn': '1',
      'pl': '10000',
      'total': total,
      'brandId': brandId,
      'carModelId': carModelId,
      'carTypeId': carTypeId,
      'manufactureYearId': manufactureYearId,
      'mileageState': mileageState,
    });
    final response = await _post(URLs.GetStockUrl, body);
    return _parse(response, StocksResponse.fromJson);
  }

  Future<CarTypeEquipmentInfoResponse?> getCarEquipments(
      String carTypeId) async {
    final body = await _buildBody({
      'carTypeId': carTypeId,
      'pn': '1',
      'pl': '10000',
    });
    final response = await _post(URLs.GetCarTypeEquipmentInfoUrl, body);
    return _parse(response, CarTypeEquipmentInfoResponse.fromJson);
  }

  Future<CarTypeSpecTypeResponse?> getCarSpecTypes(String carTypeId) async {
    final body = await _buildBody({
      'carType': {'id': carTypeId},
      'pn': '1',
      'pl': '10000',
    });
    final response = await _post(URLs.GetCarTypeSpecTypesUrl, body);
    return _parse(response, CarTypeSpecTypeResponse.fromJson);
  }

  Future<ApplicationsInfoResponse?> getInfo() async {
    final body = await _buildBody({'pn': '1', 'pl': '10000'});
    final response = await _post(URLs.GetApplicationsInfoUrl, body);
    return _parse(response, ApplicationsInfoResponse.fromJson);
  }

  Future<UpdateResponse?> checkVersion() async {
    final response = await _post(URLs.GetVersionUrl, await _buildBody({}));
    return _parse(response, UpdateResponse.fromJson);
  }

  Future<AccountAnnouncmentModel?> getAccountAnnouncementStatus() async {
    final response =
        await _post(URLs.GetAccountAnnouncementInfoUrl, await _buildBody({}));
    return _parse(response, AccountAnnouncmentModel.fromJson);
  }

  Future<BaseResponse?> updateAnnouncements(
      String all, String carModelIds) async {
    final body = await _buildBody({'all': all, 'carModelIds': carModelIds});
    final response = await _post(URLs.UpdateAccountAnnouncementUrl, body);
    return _parse(response, BaseResponse.fromJson);
  }
}

class InsertImageBody {
  final List<DocumentItem> documents;

  const InsertImageBody({this.documents = const []});

  factory InsertImageBody.fromJson(Map<String, dynamic> json) {
    final list = json['documents'] as List<dynamic>? ?? [];
    return InsertImageBody(
      documents: list
          .map((e) => DocumentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'documents': documents.map((d) => d.toJson()).toList(),
      };
}

class DocumentItem {
  final int? index;
  final String? content;
  final String? fileName;
  final String? fileType;

  const DocumentItem({this.index, this.content, this.fileName, this.fileType});

  factory DocumentItem.fromJson(Map<String, dynamic> json) => DocumentItem(
        index: json['index'] as int?,
        content: json['content'] as String?,
        fileName: json['fileName'] as String?,
        fileType: json['fileType'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'index': index,
        'content': content,
        'fileName': fileName,
        'fileType': fileType,
      };
}
