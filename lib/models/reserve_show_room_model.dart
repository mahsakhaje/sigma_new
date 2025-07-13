class ReserveShowRoomResponse {
  int? status;
  String? message;
  String? persianMessage;
  Reservation? reservation;

  ReserveShowRoomResponse({this.status, this.message, this.persianMessage, this.reservation});

  ReserveShowRoomResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    reservation = json['reservation'] != null
        ? new Reservation.fromJson(json['reservation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    if (this.reservation != null) {
      data['reservation'] = this.reservation!.toJson();
    }
    return data;
  }
}

class Reservation {
  String? id;
  String? salesOrderId;
  String? canceled;
  String? timespanDate;
  String? orderNumber;
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
  Account? account;
  String? car;
  String? registerDate;
  String? rating;
  String? carService;

  Reservation(
      {this.id,
      this.salesOrderId,
      this.canceled,
      this.timespanDate,
      this.orderNumber,
      this.timespanFromHour,
      this.timespanToHour,
      this.timespanCapacityId,
      this.timespanCapacityDate,
      this.mileage,
      this.mileageState,
      this.carTypeDescription,
      this.carModelDescription,
      this.brandDescription,
      this.carTypeId,
      this.persianYear,
      this.colorDescription,
      this.accountName,
      this.accountLastName,
      this.accountCellNumber,
      this.timespanDateFrom,
      this.timespanDateTo,
      this.account,
      this.car,
      this.registerDate,
      this.rating,
      this.carService});

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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

class Account {
  String? id;
  String? isReal;
  String? nationalId;
  String? cellNumber;
  String? password;
  String? name;
  String? email;
  String? lastName;
  String? balance;

  Account(
      {this.id,
      this.isReal,
      this.nationalId,
      this.cellNumber,
      this.password,
      this.name,
      this.email,
      this.lastName,
      this.balance});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isReal = json['isReal'];
    nationalId = json['nationalId'];
    cellNumber = json['cellNumber'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    lastName = json['lastName'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isReal'] = this.isReal;
    data['nationalId'] = this.nationalId;
    data['cellNumber'] = this.cellNumber;
    data['password'] = this.password;
    data['name'] = this.name;
    data['email'] = this.email;
    data['lastName'] = this.lastName;
    data['balance'] = this.balance;
    return data;
  }
}
