
import 'package:sigma/models/reserve_show_room_model.dart';

class MyReservationsResponse {
  int? status;
  String? message;
  String? count;
  List<Reservations>? reservations;

  MyReservationsResponse(
      {this.status, this.message, this.count, this.reservations});

  MyReservationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['reservations'] != null) {
      reservations = <Reservations>[];
      json['reservations'].forEach((v) {
        reservations!.add(new Reservations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.reservations != null) {
      data['reservations'] = this.reservations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservations {
  String? id;
  String? salesOrderId;
  String? canceled;
  String? timespanDate;
  String? rateComment;
  String? rated;
  String? timespanFromHour;
  String? timespanToHour;
  String? timespanCapacityId;
  String? timespanCapacityDate;
  String? mileage;
  String? mileageState;
  String? carTypeDescription;
  String? carModelDescription;
  String? brandDescription;
  String? carTypeId;
  String? persianYear;
  String? colorDescription;
  String? accountName;
  String? accountLastName;
  String? accountCellNumber;
  String? timespanDateFrom;
  String? timespanDateTo;
  String? userId;
  String? reservationState;
  String? reservationStateText;
  Account? account;
  String? car;
  String? registerDate;
  String? userLastName;
  String? userName;
  String? rating;
  String? carService;
  String? unitAddress;
  String? orderNumber;

  Reservations(
      {this.id,
      this.salesOrderId,
      this.canceled,
      this.orderNumber,
      this.unitAddress,
      this.timespanDate,
      this.timespanFromHour,
      this.timespanToHour,
      this.userLastName,
      this.userName,
      this.timespanCapacityId,
      this.timespanCapacityDate,
      this.mileage,
      this.rated,
      this.mileageState,
      this.carTypeDescription,
      this.carModelDescription,
      this.brandDescription,
      this.carTypeId,
      this.rateComment,
      this.persianYear,
      this.colorDescription,
      this.accountName,
      this.accountLastName,
      this.accountCellNumber,
      this.timespanDateFrom,
      this.timespanDateTo,
      this.userId,
      this.reservationState,
      this.reservationStateText,
      this.account,
      this.car,
      this.registerDate,
      this.rating,
      this.carService});

  Reservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rated = json['rated'];
    userLastName = json['userLastName'];
    userName = json['userName'];
    rateComment = json['rateComment'];
    unitAddress = json['unitAddress'];
    salesOrderId = json['salesOrderId'];
    canceled = json['canceled'];
    orderNumber = json['orderNumber'];
    timespanDate = json['timespanDate'];
    timespanFromHour = json['timespanFromHour'];
    timespanToHour = json['timespanToHour'];
    timespanCapacityId = json['timespanCapacityId'];
    timespanCapacityDate = json['timespanCapacityDate'];
    mileage = json['mileage'];
    mileageState = json['mileageState'];
    carTypeDescription = json['carTypeDescription'];
    carModelDescription = json['carModelDescription'];
    brandDescription = json['brandDescription'];
    carTypeId = json['carTypeId'];
    persianYear = json['persianYear'];
    colorDescription = json['colorDescription'];
    accountName = json['accountName'];
    accountLastName = json['accountLastName'];
    accountCellNumber = json['accountCellNumber'];
    timespanDateFrom = json['timespanDateFrom'];
    timespanDateTo = json['timespanDateTo'];
    userId = json['userId'];
    reservationState = json['reservationState'];
    reservationStateText = json['reservationStateText'];
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
    car = json['car'];
    registerDate = json['registerDate'];
    rating = json['rating'];
    carService = json['carService'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesOrderId'] = this.salesOrderId;
    data['canceled'] = this.canceled;
    data['timespanDate'] = this.timespanDate;
    data['timespanFromHour'] = this.timespanFromHour;
    data['timespanToHour'] = this.timespanToHour;
    data['timespanCapacityId'] = this.timespanCapacityId;
    data['timespanCapacityDate'] = this.timespanCapacityDate;
    data['mileage'] = this.mileage;
    data['mileageState'] = this.mileageState;
    data['carTypeDescription'] = this.carTypeDescription;
    data['carModelDescription'] = this.carModelDescription;
    data['brandDescription'] = this.brandDescription;
    data['carTypeId'] = this.carTypeId;
    data['persianYear'] = this.persianYear;
    data['colorDescription'] = this.colorDescription;
    data['accountName'] = this.accountName;
    data['accountLastName'] = this.accountLastName;
    data['accountCellNumber'] = this.accountCellNumber;
    data['timespanDateFrom'] = this.timespanDateFrom;
    data['timespanDateTo'] = this.timespanDateTo;
    data['userId'] = this.userId;
    data['reservationState'] = this.reservationState;
    data['reservationStateText'] = this.reservationStateText;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    data['car'] = this.car;
    data['registerDate'] = this.registerDate;
    data['rating'] = this.rating;
    data['carService'] = this.carService;
    return data;
  }
}
