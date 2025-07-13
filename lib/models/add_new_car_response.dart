class AddNewCarResponse {
  int? status;
  String? message;
  Car? car;

  AddNewCarResponse({this.status, this.message, this.car});

  AddNewCarResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    return data;
  }
}

class Car {
  String? id;
  String? description;
  String? mileage;
  String? mileageState;
  String? chassisNumber;
  String? accountName;
  String? accountLastName;
  String? accountCellNumber;
  String? brandId;
  String? brandDescription;
  String? carModelId;
  String? carModelDescription;
  String? carTypeId;
  String? carTypeDescription;
  String? manufactureYearId;
  String? persianYear;
  String? miladiYear;
  String? fromMileage;
  String? toMileage;
  String? fromManufactureYear;
  String? toManufactureYear;
  String? colorId;
  String? colorDescription;
  String? trimColorId;
  String? trimColorDescription;
  String? owner;
  String? plateNumber;
  String? expertOrders;
  String? reservations;
  String? purchaseOrders;

  Car(
      {this.id,
        this.description,
        this.mileage,
        this.mileageState,
        this.chassisNumber,
        this.accountName,
        this.accountLastName,
        this.accountCellNumber,
        this.brandId,
        this.brandDescription,
        this.carModelId,
        this.carModelDescription,
        this.carTypeId,
        this.carTypeDescription,
        this.manufactureYearId,
        this.persianYear,
        this.miladiYear,
        this.fromMileage,
        this.toMileage,
        this.fromManufactureYear,
        this.toManufactureYear,
        this.colorId,
        this.colorDescription,
        this.trimColorId,
        this.trimColorDescription,
        this.owner,
        this.plateNumber,
        this.expertOrders,
        this.reservations,
        this.purchaseOrders});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    mileage = json['mileage'];
    mileageState = json['mileageState'];
    chassisNumber = json['chassisNumber'];
    accountName = json['accountName'];
    accountLastName = json['accountLastName'];
    accountCellNumber = json['accountCellNumber'];
    brandId = json['brandId'];
    brandDescription = json['brandDescription'];
    carModelId = json['carModelId'];
    carModelDescription = json['carModelDescription'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    manufactureYearId = json['manufactureYearId'];
    persianYear = json['persianYear'];
    miladiYear = json['miladiYear'];
    fromMileage = json['fromMileage'];
    toMileage = json['toMileage'];
    fromManufactureYear = json['fromManufactureYear'];
    toManufactureYear = json['toManufactureYear'];
    colorId = json['colorId'];
    colorDescription = json['colorDescription'];
    trimColorId = json['trimColorId'];
    trimColorDescription = json['trimColorDescription'];
    owner = json['owner'];
    plateNumber = json['plateNumber'];
    expertOrders = json['expertOrders'];
    reservations = json['reservations'];
    purchaseOrders = json['purchaseOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['mileage'] = this.mileage;
    data['mileageState'] = this.mileageState;
    data['chassisNumber'] = this.chassisNumber;
    data['accountName'] = this.accountName;
    data['accountLastName'] = this.accountLastName;
    data['accountCellNumber'] = this.accountCellNumber;
    data['brandId'] = this.brandId;
    data['brandDescription'] = this.brandDescription;
    data['carModelId'] = this.carModelId;
    data['carModelDescription'] = this.carModelDescription;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['manufactureYearId'] = this.manufactureYearId;
    data['persianYear'] = this.persianYear;
    data['miladiYear'] = this.miladiYear;
    data['fromMileage'] = this.fromMileage;
    data['toMileage'] = this.toMileage;
    data['fromManufactureYear'] = this.fromManufactureYear;
    data['toManufactureYear'] = this.toManufactureYear;
    data['colorId'] = this.colorId;
    data['colorDescription'] = this.colorDescription;
    data['trimColorId'] = this.trimColorId;
    data['trimColorDescription'] = this.trimColorDescription;
    data['owner'] = this.owner;
    data['plateNumber'] = this.plateNumber;
    data['expertOrders'] = this.expertOrders;
    data['reservations'] = this.reservations;
    data['purchaseOrders'] = this.purchaseOrders;
    return data;
  }
}
