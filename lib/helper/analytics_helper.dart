import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
String get platformName {
  if (Platform.isAndroid) return 'android';
  if (Platform.isIOS) return 'ios';
  return 'unknown';
}
class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService instance = AnalyticsService._();
  final FirebaseAnalytics _fa = FirebaseAnalytics.instance;

  Future<void> _log(String name, Map<String,Object>? params) async {
    try {
      if (kDebugMode) debugPrint('[GA4] $name $params');
      await _fa.logEvent(name:name, parameters: params);
    } catch(e){
      if(kDebugMode) debugPrint(e.toString()+'GA4************************************');
    }
  }

  Future<void> login()=>_log('login',{'platform':platformName});
  Future<void> signUp({required String signupMethod})=>
      _log('sign_up',{'platform':platformName,'signup_method':signupMethod});
  Future<void> sellOrderSubmitted({required String carModel,required String city})=>
      _log('sell_order_submitted',{'car_model':carModel,'city':city,'platform':platformName});
  Future<void> buyRequestSubmitted({required String desiredModel,required String city})=>
      _log('buy_request_submitted',{'desired_model':desiredModel,'city':city,'platform':platformName});
  Future<void> viewCar({required String carModel,required String city})=>
      _log('view_car',{'car_model':carModel,'city':city});

}
