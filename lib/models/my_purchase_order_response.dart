class MyBuyOrdersResponse {
  int? status;
  String? message;
  String? persianMessage;
  String? count;
  List<PurchaseOrders>? purchaseOrders;

  MyBuyOrdersResponse(
      {this.status,
        this.message,
        this.persianMessage,
        this.count,
        this.purchaseOrders});

  MyBuyOrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    persianMessage = json['persianMessage'];
    count = json['count'];
    if (json['purchaseOrders'] != null) {
      purchaseOrders = <PurchaseOrders>[];
      json['purchaseOrders'].forEach((v) {
        purchaseOrders!.add(new PurchaseOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['persianMessage'] = this.persianMessage;
    data['count'] = this.count;
    if (this.purchaseOrders != null) {
      data['purchaseOrders'] =
          this.purchaseOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseOrders {
  String? id;
  String? orderNumber;
  String? purchaseAmount;
  String? budget;
  String? state;
  String? stateText;
  String? carTypeId;
  String? carTypeDescription;
  String? accountName;
  String? accountLastName;
  String? accountCellNumber;
  String? accountOrgName;
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
  String? registerTime;
  String? q1Value;
  String? q2Value;
  String? rateComment;
  String? rated;
  String? similarItems;
  String? seenByReceptor;
  String? fromDate;
  String? toDate;
  String? carSwap;
  String? carSwapComment;
  String? cityDescription;
  String? cityId;

  PurchaseOrders(
      {this.id,
        this.orderNumber,
        this.purchaseAmount,
        this.budget,
        this.state,
        this.stateText,
        this.carTypeId,
        this.carTypeDescription,
        this.accountName,
        this.accountLastName,
        this.accountCellNumber,
        this.accountOrgName,
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
        this.registerTime,
        this.q1Value,
        this.q2Value,
        this.rateComment,
        this.rated,
        this.similarItems,
        this.seenByReceptor,
        this.fromDate,
        this.toDate,
        this.carSwap,
        this.carSwapComment,
        this.cityDescription,
        this.cityId});

  PurchaseOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    purchaseAmount = json['purchaseAmount'];
    budget = json['budget'];
    state = json['state'];
    stateText = json['stateText'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    accountName = json['accountName'];
    accountLastName = json['accountLastName'];
    accountCellNumber = json['accountCellNumber'];
    accountOrgName = json['accountOrgName'];
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
    registerTime = json['registerTime'];
    q1Value = json['q1Value'];
    q2Value = json['q2Value'];
    rateComment = json['rateComment'];
    rated = json['rated'];
    similarItems = json['similarItems'];
    seenByReceptor = json['seenByReceptor'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    carSwap = json['carSwap'];
    carSwapComment = json['carSwapComment'];
    cityDescription = json['cityDescription'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNumber'] = this.orderNumber;
    data['purchaseAmount'] = this.purchaseAmount;
    data['budget'] = this.budget;
    data['state'] = this.state;
    data['stateText'] = this.stateText;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['accountName'] = this.accountName;
    data['accountLastName'] = this.accountLastName;
    data['accountCellNumber'] = this.accountCellNumber;
    data['accountOrgName'] = this.accountOrgName;
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
    data['registerTime'] = this.registerTime;
    data['q1Value'] = this.q1Value;
    data['q2Value'] = this.q2Value;
    data['rateComment'] = this.rateComment;
    data['rated'] = this.rated;
    data['similarItems'] = this.similarItems;
    data['seenByReceptor'] = this.seenByReceptor;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['carSwap'] = this.carSwap;
    data['carSwapComment'] = this.carSwapComment;
    data['cityDescription'] = this.cityDescription;
    data['cityId'] = this.cityId;
    return data;
  }
}
