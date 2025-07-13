class InsertPurchaseOrderResponse {
  int? status;
  String? message;
  PurchaseOrder? purchaseOrder;

  InsertPurchaseOrderResponse({this.status, this.message, this.purchaseOrder});

  InsertPurchaseOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    purchaseOrder = json['purchaseOrder'] != null
        ? new PurchaseOrder.fromJson(json['purchaseOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.purchaseOrder != null) {
      data['purchaseOrder'] = this.purchaseOrder!.toJson();
    }
    return data;
  }
}

class PurchaseOrder {
  String? id;
  String? orderNumber;
  String? purchaseAmount;
  String? budget;
  String? state;
  String? carTypeId;
  String? carTypeDescription;
  String? accountName;
  String? accountLastName;
  String? accountCellNumber;
  String? carModelDescription;
  String? carModelId;
  String? brandId;
  String? brandDescription;
  String? colorId;
  String? colorCode;
  String? colorDescription;
  String? trimColorId;
  String? trimColorDescription;
  String? fromMileage;
  String? toMileage;
  String? fromManufactureYear;
  String? toManufactureYear;
  String? mileageStatus;
  String? registerDate;
  String? q1Value;
  String? q2Value;
  String? rateComment;
  String? rated;

  PurchaseOrder(
      {this.id,
        this.orderNumber,
        this.purchaseAmount,
        this.budget,
        this.state,
        this.carTypeId,
        this.carTypeDescription,
        this.accountName,
        this.accountLastName,
        this.accountCellNumber,
        this.carModelDescription,
        this.carModelId,
        this.brandId,
        this.brandDescription,
        this.colorId,
        this.colorCode,
        this.colorDescription,
        this.trimColorId,
        this.trimColorDescription,
        this.fromMileage,
        this.toMileage,
        this.fromManufactureYear,
        this.toManufactureYear,
        this.mileageStatus,
        this.registerDate,
        this.q1Value,
        this.q2Value,
        this.rateComment,
        this.rated});

  PurchaseOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    purchaseAmount = json['purchaseAmount'];
    budget = json['budget'];
    state = json['state'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    accountName = json['accountName'];
    accountLastName = json['accountLastName'];
    accountCellNumber = json['accountCellNumber'];
    carModelDescription = json['carModelDescription'];
    carModelId = json['carModelId'];
    brandId = json['brandId'];
    brandDescription = json['brandDescription'];
    colorId = json['colorId'];
    colorCode = json['colorCode'];
    colorDescription = json['colorDescription'];
    trimColorId = json['trimColorId'];
    trimColorDescription = json['trimColorDescription'];
    fromMileage = json['fromMileage'];
    toMileage = json['toMileage'];
    fromManufactureYear = json['fromManufactureYear'];
    toManufactureYear = json['toManufactureYear'];
    mileageStatus = json['mileageStatus'];
    registerDate = json['registerDate'];
    q1Value = json['q1Value'];
    q2Value = json['q2Value'];
    rateComment = json['rateComment'];
    rated = json['rated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNumber'] = this.orderNumber;
    data['purchaseAmount'] = this.purchaseAmount;
    data['budget'] = this.budget;
    data['state'] = this.state;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['accountName'] = this.accountName;
    data['accountLastName'] = this.accountLastName;
    data['accountCellNumber'] = this.accountCellNumber;
    data['carModelDescription'] = this.carModelDescription;
    data['carModelId'] = this.carModelId;
    data['brandId'] = this.brandId;
    data['brandDescription'] = this.brandDescription;
    data['colorId'] = this.colorId;
    data['colorCode'] = this.colorCode;
    data['colorDescription'] = this.colorDescription;
    data['trimColorId'] = this.trimColorId;
    data['trimColorDescription'] = this.trimColorDescription;
    data['fromMileage'] = this.fromMileage;
    data['toMileage'] = this.toMileage;
    data['fromManufactureYear'] = this.fromManufactureYear;
    data['toManufactureYear'] = this.toManufactureYear;
    data['mileageStatus'] = this.mileageStatus;
    data['registerDate'] = this.registerDate;
    data['q1Value'] = this.q1Value;
    data['q2Value'] = this.q2Value;
    data['rateComment'] = this.rateComment;
    data['rated'] = this.rated;
    return data;
  }
}
