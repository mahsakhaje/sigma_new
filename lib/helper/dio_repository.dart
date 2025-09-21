import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/storage_helper.dart';
import 'package:sigma/helper/url_addresses.dart';
import 'package:sigma/models/AllCitiesResponse.dart';
import 'package:sigma/models/AllProviencesResponse.dart';
import 'package:sigma/models/ChassiInquiry_model.dart';
import 'package:sigma/models/PriceItems%20Response.dart';
import 'package:sigma/models/UpdateModel.dart';
import 'package:sigma/models/about_us_model.dart';
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
import 'package:sigma/models/color_response_model.dart';
import 'package:sigma/models/confirm_payment_model.dart';
import 'package:sigma/models/discount_response.dart';
import 'package:sigma/models/estimate_response.dart';
import 'package:sigma/models/expert_order_model.dart';
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
import 'package:sigma/models/published_transaction_response.dart';
import 'package:sigma/models/questions_model.dart';
import 'package:sigma/models/reserve_show_room_model.dart';
import 'package:sigma/models/rules_model.dart';
import 'package:sigma/models/showrooms_unites_model.dart';
import 'package:sigma/models/showroos_cities_response.dart';
import 'package:sigma/models/sigma_rales_response_model.dart';
import 'package:sigma/models/suggestiontypes_model.dart';
import 'package:sigma/models/telephone_model.dart';
import 'package:sigma/models/tracking_sales_model.dart';
import 'package:sigma/models/user_info_model.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:file_saver/file_saver.dart';
import '../models/get_expert_amount_response.dart';
import '../models/insert_order_response.dart';
import '../models/update_insert_order_response.dart';

class DioClient {
  static final DioClient instance = DioClient._privateConstructor();
  final Dio _dio;
  String? _token;

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
    _initialize();
  }

  void _initialize() {
    if (!kIsWeb) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
  }

  Future<Response?> _makePostRequest(String url, Map<String, dynamic> data,
      {bool isBytes = false}) async {
    print(URLs.BaseUrl + url);
    print(data);

    try {
      final token = await _getToken();

      Response response = await _dio.post(
        url,
        data: jsonEncode(data),
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            responseType: isBytes ? ResponseType.bytes : ResponseType.json),
      );
      print('****');
      print(response);
      // if(response.data['message']=='INVALID_TOKEN'){
      //   showToast(ToastState.ERROR, response.data['persianMessage']);
      // }
      return response;
    } catch (e) {
      debugPrint("Error making POST request: $e");
      return null;
    }
  }

  Future<BannersResponse?> getBanners() async {
    final response = await _makePostRequest(URLs.GetApplicationBannersUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return BannersResponse.fromJson(response.data);
    }

    return null;
  }

  Future<BaseResponse?> insertSuggestion({
    required String id,
    required String comment,
  }) async {
    final response = await _makePostRequest(URLs.GetInsertSuggestionUrl, {
      'suggestion': {
        'comment': comment,
        'typeId': id,
      },
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return BaseResponse.fromJson(response.data);
    }

    return null;
  }

  Future<SuggestionTypesResponse?> getSuggestionTypes() async {
    final response = await _makePostRequest(URLs.GetSuggestionTypesUrl, {
      'pn': '1',
      'pl': '1000',
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return SuggestionTypesResponse.fromJson(response.data);
    }

    return null;
  }

  Future<ConfirmPaymentResponse?> confirmPayment({
    required String orderId,
  }) async {
    final response = await _makePostRequest(URLs.ConfirmPaymentUrl, {
      'discountCode': '',
      'orderId': orderId,
      'payType': 'CREDIT',
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return ConfirmPaymentResponse.fromJson(response.data);
    }

    return null;
  }

  Future<RulesResponse?> getPrivacyRules() async {
    final response = await _makePostRequest(
      URLs.GetPrivacyRulesUrl,
      {
        'token': getShortToken(),
        'version': await getVersion(),
      },
    );

    return response?.statusCode == 200
        ? RulesResponse.fromJson(response?.data)
        : null;
  }

  Future<BaseResponse?> hasActiveOrderWithChassisNumber(String id) async {
    final response =
        await _makePostRequest(URLs.GetHasActiveOrderWithChassisNumberUrl, {
      'car': {'id': id},
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return BaseResponse.fromJson(response.data);
    }

    return null;
  }

  Future<RulesResponse?> getRules() async {
    final response = await _makePostRequest(
      URLs.GetRegistrationRulesUrl,
      {
        'token': await getShortToken(),
        // Changed from empty string to actual token
        'version': await getVersion(),
      },
    );

    return response?.statusCode == 200
        ? RulesResponse.fromJson(response?.data)
        : null;
  }

  Future<LoginResponse?> confirmRegister({
    required String code,
    required String cellNumber,
    required String referralCode,
  }) async {
    final response = await _makePostRequest(
      URLs.ConfirmRegisterUrl,
      {
        'account': {
          'cellNumber': cellNumber.toEnglishDigit(),
          'password': code.toEnglishDigit(),
          'referralCode': referralCode.toEnglishDigit(),
        },
        'token': 'null', // Kept as string 'null' to match original behavior
        'version': await getVersion(),
      },
    );

    return response?.statusCode == 200
        ? LoginResponse.fromJson(response?.data)
        : null;
  }

  Future<BaseResponse?> changeLike({required String id}) async {
    final response = await _makePostRequest(URLs.ChangeLikeUrl, {
      'salesOrder': {
        'id': id,
      },
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? BaseResponse.fromJson(response?.data)
        : null;
  }

  Future<SigmaSalesOrderResponse?> getFavourites() async {
    final response = await _makePostRequest(URLs.FavouritesUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? SigmaSalesOrderResponse.fromJson(response?.data)
        : null;
  }

  Future<LoginResponse?> getTokenRequest() async {
    print('here5');

    Response response = await _dio.post(URLs.TokenUrl,
        data: jsonEncode(UniversalPlatform.isAndroid
            ? {
                "username": "APP_ANDROID",
                "password": "aPP@nd",
              }
            : {
                "username": "APP_PWA",
                "password": "App\$wa",
              }));
    if (response?.statusCode == 200) {
      return LoginResponse.fromJson(response?.data);
    }
    return null;
  }

  Future<BlogResponse?> getBlogs({
    required int pn,
    required int pl,
  }) async {
    final response = await _makePostRequest(URLs.BlogsUrl, {
      'pl': pl.toString(),
      'pn': pn.toString(),
      'version': await getVersion(),
      'token': getShortToken(), // Added missing token parameter
    });

    return response?.statusCode == 200
        ? BlogResponse.fromJson(response?.data)
        : null;
  }

  Future<PublishedTransactionsResponse?> getPublishedTransactions({
    required int pn,
    required int pl,
  }) async {
    final response = await _makePostRequest(URLs.PublishedTransactionsUrl, {
      'pl': pl.toString(),
      'pn': pn.toString(),
      'token': await getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? PublishedTransactionsResponse.fromJson(response?.data)
        : null;
  }

  Future<CancelReasonResponse?> getCancelReasons() async {
    final response = await _makePostRequest(URLs.CancelReasonUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? CancelReasonResponse.fromJson(response?.data)
        : null;
  }

  Future<GetAvailebleTimeResponse?> getAvailebleTimeForShowRoom({
    required String id,
  }) async {
    final response =
        await _makePostRequest('${URLs.GetAvailebleTimeUrl}ForShowRoom', {
      'token': await getShortToken(),
      'unit': {'id': id},
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? GetAvailebleTimeResponse.fromJson(response?.data)
        : null;
  }

  Future<SigmaSalesOrderResponse?> getSalesOrdersWithFilter({
    String? brandId = '',
    String? carModelId = '',
    String? carTypeId = '',
    String? carTypeIds = '',
    String? colorId = '',
    String? cityId = '',
    String? state,
    String? cityIds = '',
    String? fromAmount = '',
    String? fromYear = '',
    String? toAmount = '',
    String? toYear = '',
    String? trimColorId = '',
    required int pn,
    required int pl,
  }) async {
    var data = {
      'brandIds': brandId ?? '',
      'carModelId': carModelId ?? '',
      'carModelIds': carModelId ?? '',
      'carTypeIds': carTypeIds ?? '',
      'colorId': colorId ?? "",
      'fromAmount': fromAmount,
      'fromYear': fromYear,
      'cityId': cityId ?? '',
      'carState': state ?? '',
      'cityIds': cityIds ?? '',
      'toAmount': toAmount,
      'toYear': toYear,
      'trimColorId': trimColorId,
      'pl': pl.toString(),
      'pn': pn.toString(),
      'token': await getShortToken(),
      'version': await getVersion(),
    };
    print(
      {'carState': state ?? ''},
    );
    final response =
        await _makePostRequest(URLs.GetSalesOrdersWithFilterUrl, data);
    print(response);
    return response?.statusCode == 200
        ? SigmaSalesOrderResponse.fromJson(response?.data)
        : null;
  }

  Future<InsertOrderResponse?> insertOrderData({
    required String carId,
    required String milageStatus,
    required String mileage,
    required String comment,
    required String referredId,
    required String amount,
    required bool IwillTakeCar,
    required String? referredName,
    required String? referredLastName,
    required String isSwap,
    required String commentSwap,
    required String? accountManagerId,
    required String? referredNationalId,
    required Map bodies,
    required List<Map> documents,
  }) async {
    final response = await _makePostRequest(URLs.InsertOrderUrl, {
      'salesOrder': {
        'carId': carId,
        'comment': comment.toEnglishDigit(),
        'declaredAmount': amount.toEnglishDigit(),
        'mileage': mileage.toEnglishDigit(),
        'documents': documents,
        'carSwap': isSwap,
        'carSwapComment': commentSwap,
        'accountManagerId': accountManagerId,
        'mileageState': milageStatus,
        'referredId': referredId,
        'referred': IwillTakeCar ? '0' : '1',
        'referredLastName': referredLastName,
        'referredName': referredName,
        'referredNationalId': referredNationalId?.toEnglishDigit(),
        'bodyDetails': bodies,
      },
      'token': await getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? InsertOrderResponse.fromJson(response?.data)
        : null;
  }

  Future<UpdateInsertOrderResponse?> insertPhotos({
    required InsertImageBody body,
  }) async {
    final response = await _makePostRequest(
      '/salesorders/updateSalesOrderWithDocuments',
      body.toJson(),
    );

    return response?.statusCode == 200
        ? UpdateInsertOrderResponse.fromJson(response?.data)
        : null;
  }

  Future<GetExpertAmountResponse?> getExpertAmountResponse({
    required String id,
  }) async {
    final response = await _makePostRequest('/salesorders/getOrderAmount', {
      'token': await getShortToken(),
      'salesOrder': {'carId': id},
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? GetExpertAmountResponse.fromJson(response?.data)
        : null;
  }

  Future<AddNewCarResponse?> addNewCar({
    required String carTypeId,
    required String chassisNumber,
    required String colorId,
    required String manufactureYearId,
    required String trimColorId,
  }) async {
    final response = await _makePostRequest(URLs.AddNewCardUrl, {
      'car': {
        'id': '',
        'carTypeId': carTypeId,
        'chassisNumber': chassisNumber.toEnglishDigit(),
        'colorId': colorId,
        'trimColorId': trimColorId,
        'manufactureYearId': manufactureYearId,
      },
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return AddNewCarResponse.fromJson(response.data);
    }
    return null;
  }

  Future<ChassiInquiryResponse?> getInquiryChassisNumber({
    required String chassisNumber,
  }) async {
    final response = await _makePostRequest(URLs.GetInquiryChassisNumberUrl, {
      'chassisNumber': chassisNumber.toEnglishDigit(),
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      // showMessage(response!.data);
      return ChassiInquiryResponse.fromJson(response?.data);
    }

    return null;
  }

  Future<TrackingSalesOrderResponse?> trackSalesOrder({
    required String id,
  }) async {
    final response = await _makePostRequest(URLs.TrackingSalesOrderUrl, {
      'salesOrder': {'id': id},
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return TrackingSalesOrderResponse.fromJson(response.data);
    }

    return null;
  }

  Future<String?> getExpertReportInTracking(String id) async {
    final response = await _makePostRequest(
      URLs.ExpertOrderPrintUrl,
      {
        'expertOrder': {'id': id},
        'version': await getVersion(),
      },
      isBytes: true,
    );

    if (response?.statusCode == 200) {
      return await saveFile(id, response!.data);
    }

    return null;
  }

  Future<String?> getContractReportInTracking(String orderNumber) async {
    final response = await _makePostRequest(
      URLs.ContractPrintUrl,
      {
        'salesOrder': {'orderNumber': orderNumber},
        'version': await getVersion(),
      },
      isBytes: true,
    );

    if (response?.statusCode == 200) {
      return await saveFile(orderNumber, response!.data);
    }

    return null;
  }

  Future<AddNewCarResponse?> updateNewCar({
    required String carTypeId,
    required String id,
    required String chassisNumber,
    required String colorId,
    required String manufactureYearId,
    required String trimColorId,
  }) async {
    final response = await _makePostRequest(URLs.UpdateCardUrl, {
      'car': {
        'id': id,
        'carTypeId': carTypeId,
        'chassisNumber': chassisNumber.toEnglishDigit(),
        'colorId': colorId,
        'trimColorId': trimColorId,
        'manufactureYearId': manufactureYearId,
      },
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return AddNewCarResponse.fromJson(response.data);
    }
    return null;
  }

  Future<AddNewCarResponse?> deleteCar({
    required String id,
  }) async {
    final response = await _makePostRequest(URLs.DeleteCarUrl, {
      'car': {'id': id},
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return AddNewCarResponse.fromJson(response.data);
    }
    return null;
  }

  Future<CarDetailResponse?> getCarDetail({required String id}) async {
    final response = await _makePostRequest(URLs.GetSalesOrderInfoUrl, {
      'orderId': id,
      'token': getShortToken(), // Added token that was missing
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? CarDetailResponse.fromJson(response?.data)
        : null;
  }

  Future<CarInfoResponse?> getCarInfo({required String id}) async {
    final response = await _makePostRequest(URLs.GetCarInfoUrl, {
      'car': {'id': id},
      'token': await getShortToken(), // Added token that was missing
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? CarInfoResponse.fromJson(response?.data)
        : null;
  }

  Future<GetLoanDurationResponse?> getLoanDuration() async {
    final response = await _makePostRequest(
      URLs.GetLoanDurationsUrl,
      {
        'token': await getShortToken(), // Added token for consistency
        'version': await getVersion(), // Added version for consistency
      },
    );

    return response?.statusCode == 200
        ? GetLoanDurationResponse.fromJson(response?.data)
        : null;
  }

  Future<GetLoanPaymentResponse?> calculateLoanPayment(
    String amount,
    String id,
  ) async {
    final response = await _makePostRequest(
      URLs.GetCalculateLoanPaymentsUrl,
      {
        'loanDurationId': id,
        'amount': amount,
        'token': await getShortToken(),
        'version': await getVersion(),
      },
    );

    return response?.statusCode == 200
        ? GetLoanPaymentResponse.fromJson(response?.data)
        : null;
  }

  Future<ReserveShowRoomResponse?> reserveShowRoom({
    required String salesOrderId,
    required String timespanCapacityId,
  }) async {
    final response = await _makePostRequest(URLs.ReservationForShowRoomUrl, {
      'reservation': {
        'salesOrderId': salesOrderId,
        'timespanCapacityId': timespanCapacityId,
      },
      'token': await getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? ReserveShowRoomResponse.fromJson(response?.data)
        : null;
  }

  Future<String?> downloadFileFromUrl(String url, String fileName) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 && response.data != null) {
        return await saveFile(
          '${fileName}_${DateTime.now().millisecondsSinceEpoch}',
          response.data,
        );
      }
      return null;
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }

  Future<String?> getExpertReport(String id) async {
    final response = await _makePostRequest(
        URLs.GetExpertReportUrl,
        {
          'salesOrder': {'id': id},
          'version': await getVersion(),
          'token': getShortToken(),
        },
        isBytes: true);

    if (response?.statusCode == 200 && response?.data != null) {
      if (kIsWeb) {
        return await FileSaver.instance.saveFile(
          name: 'expert_report_$id',
          bytes: response!.data,
          ext: 'pdf',
          mimeType: MimeType.pdf,
        );
      } else {
        return await saveFile('expert_report_$id', response!.data);
      }
    }
    return null;
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
    required String similarItems,
    required String isSwap,
    required String wantsLoan,
    required String commentSwap,
    required String toMileage,
    required String trimColorId,
  }) async {
    final response = await _makePostRequest(URLs.InsertPurchaseOrderUrl, {
      'purchaseOrder': {
        'brandId': brandId,
        'cityId': cityId,
        'budget': budget.toEnglishDigit(),
        'carModelId': carModelId,
        'carSwap': isSwap,
        'wantsLoan': wantsLoan,
        'carSwapComment': commentSwap,
        'carTypeId': carTypeId,
        'colorId': colorId,
        'similarItems': similarItems,
        'fromManufactureYear': fromManufactureYear,
        'fromMileage': fromMileage,
        'toMileage': toMileage,
        'trimColorId': trimColorId,
        'toManufactureYear': toManufactureYear,
      },
      'token': await getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? InsertPurchaseOrderResponse.fromJson(response?.data)
        : null;
  }

  Future<SigmaSalesOrderResponse?> getAccountsSalesOrder({
    required int pn,
    required int pl,
  }) async {
    final response = await _makePostRequest(URLs.GetAccountsSalesOrderUrl, {
      'token': getShortToken(),
      'pl': pl.toString(),
      'pn': pn.toString(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? SigmaSalesOrderResponse.fromJson(response?.data)
        : null;
  }

  Future<String> _getToken() async {
    _token = StorageHelper().getToken();

    if (_token == null || JwtDecoder.isExpired(_token ?? '')) {
      var response = await getTokenRequest();
      if (response?.token != null) {
        _token = response!.token?.replaceAll('Bearer ', '');
        StorageHelper().setToken(response.token ?? "");
      }
      _token = StorageHelper().getToken();
    }

    return (_token ?? "");
  }

  Future<QuestionsResponse?> getAllQuestions() async {
    final response = await _makePostRequest(URLs.GetAllFaqContentsUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? QuestionsResponse.fromJson(response?.data)
        : null;
  }

  Future<String?> _refreshToken() async {
    try {
      var response = await _dio.post(URLs.TokenUrl, data: {
        "username": kIsWeb ? "APP_PWA" : "APP_ANDROID",
        "password": kIsWeb ? "App\$wa" : "aPP@nd",
      });
      if (response.statusCode == 200) {
        String? newToken = response.data["token"]?.replaceAll('Bearer ', '');
        StorageHelper().setToken(newToken ?? "");
        return newToken;
      }
    } catch (e) {
      debugPrint("Error refreshing token: $e");
    }
    return null;
  }

  Future<UpdateResponse?> checkVersion() async {
    final response = await _makePostRequest(URLs.GetVersionUrl, {
      'token': '',
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? UpdateResponse.fromJson(response?.data)
        : null;
  }

  Future<NotifCountResponse?> getNotifCount() async {
    final response = await _makePostRequest(URLs.GetAppAccountNotifsCountUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? NotifCountResponse.fromJson(response?.data)
        : null;
  }

  Future<NotifListResponse?> getNotifList() async {
    final response = await _makePostRequest(URLs.GetNotifsListUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? NotifListResponse.fromJson(response?.data)
        : null;
  }

  Future<LoginResponse?> setSeenNotifs() async {
    final response = await _makePostRequest(URLs.SeenNotifsUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? LoginResponse.fromJson(response?.data)
        : null;
  }

  Future<AllCarsJsonModel?> getAllCarsJson() async {
    final response =
        await _makePostRequest(URLs.AllCarsUrl, {'data-raw': '{}'});
    return response?.statusCode == 200
        ? AllCarsJsonModel.fromJson(response?.data)
        : null;
  }

  Future<LoginResponse?> verifyResetPassword({
    required String password,
    required String cellNumber,
  }) async {
    final response = await _makePostRequest(
      URLs.VerifyResetPasswordUrl,
      {
        'account': {
          'cellNumber': cellNumber.toEnglishDigit(),
          'password': password.toEnglishDigit(),
        },
        'token': 'null', // Maintained original behavior
        'version': await getVersion(),
      },
    );

    return _handleAuthResponse(response);
  }

  Future<LoginResponse?> confirmNewPassword({
    required String newPassword,
    required String cellNumber,
    required String code,
  }) async {
    final response = await _makePostRequest(
      URLs.ConfirmNewPasswordUrl,
      {
        'cellNumber': cellNumber.toEnglishDigit(),
        'verificationCode': code.toEnglishDigit(),
        'newPassword': newPassword.toEnglishDigit(),
        'token': 'null', // Maintained original behavior
        'version': await getVersion(),
      },
    );

    return _handleAuthResponse(response);
  }

  Future<LoginResponse?> sendOTP({
    required String cellNumber,
  }) async {
    final response = await _makePostRequest(
      URLs.SendOTPUrl,
      {
        'account': {'cellNumber': cellNumber.toEnglishDigit()},
        'token': ''
      },
    );

    return _handleAuthResponse(response);
  }

  Future<LoginResponse?> confirmOTP({
    required String cellNumber,
    required String password,
  }) async {
    final response = await _makePostRequest(
      URLs.ConfirmOTPUrl,
      {
        'account': {
          'cellNumber': cellNumber.toEnglishDigit(),
          'password': password
        }
      },
    );

    return _handleAuthResponse(response);
  }

// Shared response handler for auth endpoints
  LoginResponse? _handleAuthResponse(Response? response) {
    if (response?.statusCode == 200) {
      return LoginResponse.fromJson(response!.data);
    } else {
      //Get.log('Password reset error: ${response?.data}', isError: true);
      return null;
    }
  }

  Future<BaseResponse?> register(
      {required String lastName,
      required String name,
      required String orgName,
      required String gender,
      required String email,
      required String orgNationalId,
      required String geoNameId,
      required String nationalId,
      required String password,
      required String cellNumber,
      required bool isReal,
      required String referralCode}) async {
    var formData = {
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
        'isReal': isReal ? '1' : '0'
      },
      'token': 'null',
      'version': await getVersion()
    };

    final response = await _makePostRequest(URLs.RegisterUrl, formData);
    return response?.statusCode == 200
        ? BaseResponse.fromJson(response?.data)
        : null;
  }

  Future<LoginResponse?> login(String cellNumber, String password) async {
    final response = await _makePostRequest(URLs.LoginUrl, {
      'account': {
        'cellNumber': cellNumber.toEnglishDigit(),
        'password': password,
      },
      'token': '',
      'version': await getVersion(),
    });
    if (response?.statusCode == 200) {
      showMessage(response?.data);
      return LoginResponse.fromJson(response?.data);
    }
    return null;
  }

  Future<ColorResponse?> getColors() async {
    final response =
        await _makePostRequest(URLs.ColorsUrl, {'token': await _getToken()});
    return response?.statusCode == 200
        ? ColorResponse.fromJson(response?.data)
        : null;
  }

  Future<DiscountResponse?> calculateDiscount(
      String orderId, String discountCode) async {
    final response = await _makePostRequest(URLs.CalculateDiscountAmountUrl, {
      'discountCode': discountCode,
      'orderId': orderId,
      'token': await _getToken(),
    });
    return response?.statusCode == 200
        ? DiscountResponse.fromJson(response?.data)
        : null;
  }

  Future<LoginResponse?> forgetPassword({required String cellNumber}) async {
    return _makePostRequest(URLs.ResetPasswordUrl, {
      'account': {'cellNumber': cellNumber.toEnglishDigit()},
      'token': 'null',
      'version': await getVersion(),
    }).then((response) => response?.statusCode == 200
        ? LoginResponse.fromJson(response?.data)
        : null);
  }

  Future<BaseResponse?> updateUserInfo({
    required String name,
    required String lastName,
    required String cellNumber,
    required String nationalId,
    String? address,
    String? gender,
    String? orgNationalId,
    String? orgName,
    String? email,
    String? postalCode,
    String? geoNameId,
    required bool isReal,
  }) async {
    print(gender);
    return _makePostRequest(URLs.UpdateUserInfoUrl, {
      'account': {
        'name': name,
        'geoNameId': geoNameId,
        'sex': gender,
        'email': email,
        'cellNumber': cellNumber.toEnglishDigit(),
        'lastName': lastName,
        'orgName': orgName,
        'orgNationalId': orgNationalId,
        'accountAddress': address?.toEnglishDigit(),
        'postalCode': postalCode?.toEnglishDigit(),
        'isReal': isReal ? '1' : '0',
        'nationalId': nationalId.toEnglishDigit(),
      },
      'token': getShortToken(),
      'version': await getVersion(),
    }).then((response) => response?.statusCode == 200
        ? BaseResponse.fromJson(response?.data)
        : null);
  }

  Future<AboutUsModel?> getAboutUs() async {
    final response = await _makePostRequest(URLs.GetAboutUsContentUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? AboutUsModel.fromJson(response?.data)
        : null;
  }

  Future<TelephoneResponse?> getSupportTelephone() async {
    final response = await _makePostRequest(URLs.GetSupportTelephoneUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? TelephoneResponse.fromJson(response?.data)
        : null;
  }

  Future<UserInfoResponse?> getUserInfo() async {
    final response = await _makePostRequest(URLs.GetUserInfoUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? UserInfoResponse.fromJson(response?.data)
        : null;
  }

  Future<MyReservationsResponse?> getMyReservations({
    required int pn,
    required int pl,
  }) async {
    final response = await _makePostRequest(URLs.GetMyReservationsUrl, {
      'token': getShortToken(),
      'pl': pl.toString(),
      'pn': pn.toString(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? MyReservationsResponse.fromJson(response?.data)
        : null;
  }

  Future<MyCarsResponse?> getMycars({
    String query = '',
    required int pn,
    required int pl,
  }) async {
    final response = await _makePostRequest(URLs.GetMyCarsUrl, {
      'token': getShortToken(),
      'car': {'chassisNumber': query},
      'pl': pl.toString(),
      'pn': pn.toString(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? MyCarsResponse.fromJson(response?.data)
        : null;
  }

  Future<MyExpertOrdersResponse?> getMyExpertOrders({
    required int pl,
    required int pn,
  }) async {
    final response = await _makePostRequest(URLs.GetExpertOrderUrl, {
      'token': getShortToken(),
      'pl': pl.toString(),
      'pn': pn.toString(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? MyExpertOrdersResponse.fromJson(response?.data)
        : null;
  }

  Future<BaseResponse?> cancelOrder(
      String id, String reasonId, String description) async {
    final response = await _makePostRequest(URLs.CancelOrdersUrl, {
      'orderId': id,
      'reasonId': reasonId,
      'description': description,
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? BaseResponse.fromJson(response?.data)
        : null;
  }

  Future<MyBuyOrdersResponse?> getMyPurchaseOrders({
    required int pl,
    required int pn,
  }) async {
    final response = await _makePostRequest(URLs.GetPurchaseOrderUrl, {
      'token': getShortToken(),
      'pl': pl.toString(),
      'pn': pn.toString(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? MyBuyOrdersResponse.fromJson(response?.data)
        : null;
  }

  Future<BaseResponse?> cancelShowRoom({required String id}) async {
    final response = await _makePostRequest(URLs.CancelShowroomUrl, {
      'reservation': {'id': id},
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? BaseResponse.fromJson(response?.data)
        : null;
  }

  Future<OnlinePayResponse?> _handlePayment(
      String url, Map<String, dynamic> baseFormData) async {
    final response = await _makePostRequest(url, baseFormData);
    return response?.statusCode == 200
        ? OnlinePayResponse.fromJson(response?.data)
        : null;
  }

  Future<OnlinePayResponse?> payOnline({
    required String orderId,
    required String discountCode,
    required String useCredit,
    required String payType,
  }) async {
    String failureUrl, successUrl;
    if (UniversalPlatform.isAndroid) {
      failureUrl = URLs.BankCallBackFailureUrl;
      successUrl = URLs.BankCallBackSuccessUrl;
    } else if (!kIsWeb) {
      failureUrl = URLs.IosBankCallBackFailureUrl;
      successUrl = URLs.IosBankCallBackSuccessUrl;
    } else {
      failureUrl = URLs.PWAError;
      successUrl = URLs.PWASuccess;
    }

    return await _handlePayment(URLs.OnlinePaymentUrl, {
      'discountCode': discountCode.toEnglishDigit(),
      'orderId': orderId,
      'payType': payType,
      'useCredit': useCredit,
      'callBackUrlFailure': failureUrl,
      'callBackUrlSuccess': successUrl,
      'token': getShortToken(),
      'version': await getVersion(),
    });
  }

  void showMessage(Map<String, dynamic> data) {
    if (data!['status'] != 0) {
      showToast(ToastState.ERROR, data['persianMessage']);
      return;
    }
  }

  Future<MySellCarsResponse?> getCars() async {
    final response = await _makePostRequest(URLs.GetMyCarsUrl, {
      'pn': '1',
      'pl': '100',
      'token': getShortToken(),
      'version': await getVersion(),
    });
    return response?.statusCode == 200
        ? MySellCarsResponse.fromJson(response?.data)
        : null;
  }

  Future<AvailableAccountManagersResponse?> getAvailabeAccountManagers(
      String id) async {
    final response =
        await _makePostRequest(URLs.GetAvailableAccountManagersUrl, {
      'unit': {'id': id},
      'pn': '1',
      'pl': '1000',
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200) {
      showMessage(response!.data);
      return AvailableAccountManagersResponse.fromJson(response.data);
    }
    return null;
  }

  Future<bool?> checkChassiNumber(String chassisNumber) async {
    final response = await _makePostRequest(URLs.GetIsValidChassisNumberUrl, {
      'chassisNumber': chassisNumber.toEnglishDigit(),
      'token': getShortToken(),
      'version': await getVersion(),
    });

    if (response?.statusCode == 200 && response!.data['message'] == 'OK') {
      return true;
    }
    return false;
  }

  Future<AllProvincesResponse?> getProvinces() async {
    final response = await _makePostRequest(URLs.GetAllProvincesUrl, {
      'pl': '10000',
      'pn': '1',
      'token': null,
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? AllProvincesResponse.fromJson(response?.data)
        : null;
  }

  Future<ManaPricesResponse?> getManaPrices() async {
    final response = await _makePostRequest(URLs.ManaPricesUrl, {
      'pl': '50',
      'token': getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? ManaPricesResponse.fromJson(response?.data)
        : null;
  }

  Future<EstimateResponse?> estimatePrice({
    required String carTypeId,
    required String colorId,
    required String yearId,
    required String mileage,
    required List<String> itemValueIds,
  }) async {
    final response = await _makePostRequest(URLs.EstimateUrl, {
      'carTypeId': carTypeId,
      'colorId': colorId,
      'yearId': yearId,
      'mileage': mileage.toEnglishDigit(),
      'itemValueIds': itemValueIds,
      'token': getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? EstimateResponse.fromJson(response?.data)
        : null;
  }

  Future<PriceItemsResponse?> getPriceItems() async {
    final response = await _makePostRequest(URLs.EstimatePriceItemsUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? PriceItemsResponse.fromJson(response?.data)
        : null;
  }

  Future<AllCitiesResponse?> getCities(String id) async {
    final response = await _makePostRequest(URLs.GetProvinceCitiesUrl, {
      'parentId': id,
      'pl': '10000',
      'pn': '1',
      'token': null,
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? AllCitiesResponse.fromJson(response?.data)
        : null;
  }

  Future<ShowroomsUniteResponse?> getShowRoomUnites(String id) async {
    final response = await _makePostRequest(URLs.GetShowRoomsUnitesUrl, {
      'unit': {'geoNameId': id},
      'token': null,
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? ShowroomsUniteResponse.fromJson(response?.data)
        : null;
  }

  Future<ShowroomsCitiesResponse?> getShowroomCities() async {
    final response = await _makePostRequest(URLs.GetAvailableCitiesUrl, {
      'token': getShortToken(),
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? ShowroomsCitiesResponse.fromJson(response?.data)
        : null;
  }

  Future<ApplicationsInfoResponse?> getInfo() async {
    final response = await _makePostRequest(URLs.GetApplicationsInfoUrl, {
      'pl': '10000',
      'pn': '1',
      'token': null,
      'version': await getVersion(),
    });

    return response?.statusCode == 200
        ? ApplicationsInfoResponse.fromJson(response?.data)
        : null;
  }

  String getShortToken() {
    var token = StorageHelper().getShortToken() ?? '';
    return token;
  }
}

class InsertImageBody {
  List<Documents>? documents;

  InsertImageBody({this.documents});

  InsertImageBody.fromJson(Map<String, dynamic> json) {
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
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
