import 'package:flutter/material.dart';

class ChangePriceResponse {
  final int? status;
  final String? message;
  final String? persianMessage;
  final MonthlyPrices? prices1402;
  final MonthlyPrices? prices1403;
  final MonthlyPrices? prices1404;

  ChangePriceResponse({
    this.status,
    this.message,
    this.persianMessage,
    this.prices1402,
    this.prices1403,
    this.prices1404,
  });

  factory ChangePriceResponse.fromJson(Map<String, dynamic> json) {
    return ChangePriceResponse(
      status: json['status'],
      message: json['message'],
      persianMessage: json['persianMessage'],
      prices1402: json['prices1402'] != null
          ? MonthlyPrices.fromJson(json['prices1402'])
          : null,
      prices1403: json['prices1403'] != null
          ? MonthlyPrices.fromJson(json['prices1403'])
          : null,
      prices1404: json['prices1404'] != null
          ? MonthlyPrices.fromJson(json['prices1404'])
          : null,
    );
  }
}

class MonthlyPrices {
  final String? farvardin;
  final String? ordibehesht;
  final String? khordad;
  final String? tir;
  final String? mordad;
  final String? shahrivar;
  final String? mehr;
  final String? aban;
  final String? azar;
  final String? dey;
  final String? bahman;
  final String? esfand;

  MonthlyPrices({
    this.farvardin,
    this.ordibehesht,
    this.khordad,
    this.tir,
    this.mordad,
    this.shahrivar,
    this.mehr,
    this.aban,
    this.azar,
    this.dey,
    this.bahman,
    this.esfand,
  });

  factory MonthlyPrices.fromJson(Map<String, dynamic> json) {
    return MonthlyPrices(
      farvardin: json['farvardin'],
      ordibehesht: json['ordibehesht'],
      khordad: json['khordad'],
      tir: json['tir'],
      mordad: json['mordad'],
      shahrivar: json['shahrivar'],
      mehr: json['mehr'],
      aban: json['aban'],
      azar: json['azar'],
      dey: json['dey'],
      bahman: json['bahman'],
      esfand: json['esfand'],
    );
  }

  List<ChartData> toChartDataList() {
    final months = [
      'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور',
      'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'
    ];

    final values = [
      farvardin, ordibehesht, khordad, tir, mordad, shahrivar,
      mehr, aban, azar, dey, bahman, esfand
    ];

    return List.generate(12, (index) {
      final value = values[index];
      return ChartData(
        month: months[index],
        value: value != null ? double.tryParse(value) ?? 0.0 : 0.0,
      );
    });
  }
}
class ChartData {
  final String month;
  final double value;

  ChartData({
    required this.month,
    required this.value,
  });
}

// کلاس داده برای هر سال
class YearData {
  final int year;
  final List<ChartData> data;
  final Color color;

  YearData({
    required this.year,
    required this.data,
    required this.color,
  });
}