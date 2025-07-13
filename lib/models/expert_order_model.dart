class MyExpertOrdersResponse {
  int? status;
  String? message;
  String? count;
  List<ExpertOrders>? expertOrders;

  MyExpertOrdersResponse(
      {this.status, this.message, this.count, this.expertOrders});

  MyExpertOrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['expertOrders'] != null) {
      expertOrders = <ExpertOrders>[];
      json['expertOrders'].forEach((v) {
        expertOrders!.add(new ExpertOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.expertOrders != null) {
      data['expertOrders'] = this.expertOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpertOrders {
  String? id;
  String? rated;
  String? orderNumber;
  String? salesOrderId;
  String? guarantyOrderId;
  String? comment;
  String? expertAmount;
  String? state;
  String? stateText;
  String? timespanDate;
  String? timespanFromHour;
  String? timespanToHour;
  String? timespanCapacityId;
  String? timespanCapacityDate;
  String? address;
  String? accountName;
  String? accountLastName;
  String? accountCellNumber;
  String? carTypeId;
  String? carTypeDescription;
  String? carModelId;
  String? carModelDescription;
  String? brandId;
  String? brandDescription;
  String? persianYear;
  String? miladiYear;
  String? colorId;
  String? colorDescription;
  String? trimColorId;
  String? trimColorDescription;
  String? carId;
  String? chassisNumber;
  String? manufactureYearId;
  String? mileage;
  String? mileageState;
  String? carDescription;
  String? expertBranchId;
  String? expertBranchDescription;
  String? userId;
  String? userName;
  String? userLastName;
  String? userCellNumber;
  String? itemTypeComment1;
  String? itemTypeComment2;
  String? itemTypeComment3;
  String? itemTypeComment4;
  String? itemTypeComment5;
  String? itemTypeComment6;
  String? itemTypeComment7;
  String? finalStep;
  String? expertPrice;
  String? supervisorPrice;
  String? branchName;
  String? branchAddress;
  String? registerDate;
  String? receptionNumber;
  String? receptionDate;
  String? currentMileage;
  String? receptionTime;
  String? receptionHour;
  String? carOwner;
  String? referredName;
  String? referredCellNumber;
  String? referredAddress;
  String? referredNationalId;
  String? referredPostalcode;
  String? paymentType;
  String? carBodyDetails;
  String? q1Value;
  String? q2Value;
  String? rateComment;
  String? bodyDetails;
  String? documents;
  String? expertItemValues;

  ExpertOrders(
      {this.id,
      this.orderNumber,
      this.salesOrderId,
      this.guarantyOrderId,
      this.comment,
      this.expertAmount,
      this.state,
      this.stateText,
      this.timespanDate,
      this.timespanFromHour,
      this.timespanToHour,
      this.timespanCapacityId,
      this.timespanCapacityDate,
      this.address,
      this.rated,
      this.accountName,
      this.accountLastName,
      this.accountCellNumber,
      this.carTypeId,
      this.carTypeDescription,
      this.carModelId,
      this.carModelDescription,
      this.brandId,
      this.brandDescription,
      this.persianYear,
      this.miladiYear,
      this.colorId,
      this.colorDescription,
      this.trimColorId,
      this.trimColorDescription,
      this.carId,
      this.chassisNumber,
      this.manufactureYearId,
      this.mileage,
      this.mileageState,
      this.carDescription,
      this.expertBranchId,
      this.expertBranchDescription,
      this.userId,
      this.userName,
      this.userLastName,
      this.userCellNumber,
      this.itemTypeComment1,
      this.itemTypeComment2,
      this.itemTypeComment3,
      this.itemTypeComment4,
      this.itemTypeComment5,
      this.itemTypeComment6,
      this.itemTypeComment7,
      this.finalStep,
      this.expertPrice,
      this.supervisorPrice,
      this.branchName,
      this.branchAddress,
      this.registerDate,
      this.receptionNumber,
      this.receptionDate,
      this.currentMileage,
      this.receptionTime,
      this.receptionHour,
      this.carOwner,
      this.referredName,
      this.referredCellNumber,
      this.referredAddress,
      this.referredNationalId,
      this.referredPostalcode,
      this.paymentType,
      this.carBodyDetails,
      this.q1Value,
      this.q2Value,
      this.rateComment,
      this.bodyDetails,
      this.documents,
      this.expertItemValues});

  ExpertOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    salesOrderId = json['salesOrderId'];
    guarantyOrderId = json['guarantyOrderId'];
    comment = json['comment'];
    expertAmount = json['expertAmount'];
    state = json['state'];
    rated = json['rated'];
    stateText = json['stateText'];
    timespanDate = json['timespanDate'];
    timespanFromHour = json['timespanFromHour'];
    timespanToHour = json['timespanToHour'];
    timespanCapacityId = json['timespanCapacityId'];
    timespanCapacityDate = json['timespanCapacityDate'];
    address = json['address'];
    accountName = json['accountName'];
    accountLastName = json['accountLastName'];
    accountCellNumber = json['accountCellNumber'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    carModelId = json['carModelId'];
    carModelDescription = json['carModelDescription'];
    brandId = json['brandId'];
    brandDescription = json['brandDescription'];
    persianYear = json['persianYear'];
    miladiYear = json['miladiYear'];
    colorId = json['colorId'];
    colorDescription = json['colorDescription'];
    trimColorId = json['trimColorId'];
    trimColorDescription = json['trimColorDescription'];
    carId = json['carId'];
    chassisNumber = json['chassisNumber'];
    manufactureYearId = json['manufactureYearId'];
    mileage = json['mileage'];
    mileageState = json['mileageState'];
    carDescription = json['carDescription'];
    expertBranchId = json['expertBranchId'];
    expertBranchDescription = json['expertBranchDescription'];
    userId = json['userId'];
    userName = json['userName'];
    userLastName = json['userLastName'];
    userCellNumber = json['userCellNumber'];
    itemTypeComment1 = json['itemTypeComment1'];
    itemTypeComment2 = json['itemTypeComment2'];
    itemTypeComment3 = json['itemTypeComment3'];
    itemTypeComment4 = json['itemTypeComment4'];
    itemTypeComment5 = json['itemTypeComment5'];
    itemTypeComment6 = json['itemTypeComment6'];
    itemTypeComment7 = json['itemTypeComment7'];
    finalStep = json['finalStep'];
    expertPrice = json['expertPrice'];
    supervisorPrice = json['supervisorPrice'];
    branchName = json['branchName'];
    branchAddress = json['branchAddress'];
    registerDate = json['registerDate'];
    receptionNumber = json['receptionNumber'];
    receptionDate = json['receptionDate'];
    currentMileage = json['currentMileage'];
    receptionTime = json['receptionTime'];
    receptionHour = json['receptionHour'];
    carOwner = json['carOwner'];
    referredName = json['referredName'];
    referredCellNumber = json['referredCellNumber'];
    referredAddress = json['referredAddress'];
    referredNationalId = json['referredNationalId'];
    referredPostalcode = json['referredPostalcode'];
    paymentType = json['paymentType'];
    carBodyDetails = json['carBodyDetails'];
    q1Value = json['q1Value'];
    q2Value = json['q2Value'];
    rateComment = json['rateComment'];
    bodyDetails = json['bodyDetails'];
    documents = json['documents'];
    expertItemValues = json['expertItemValues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNumber'] = this.orderNumber;
    data['salesOrderId'] = this.salesOrderId;
    data['guarantyOrderId'] = this.guarantyOrderId;
    data['comment'] = this.comment;
    data['expertAmount'] = this.expertAmount;
    data['state'] = this.state;
    data['stateText'] = this.stateText;
    data['timespanDate'] = this.timespanDate;
    data['timespanFromHour'] = this.timespanFromHour;
    data['timespanToHour'] = this.timespanToHour;
    data['timespanCapacityId'] = this.timespanCapacityId;
    data['timespanCapacityDate'] = this.timespanCapacityDate;
    data['address'] = this.address;
    data['accountName'] = this.accountName;
    data['accountLastName'] = this.accountLastName;
    data['accountCellNumber'] = this.accountCellNumber;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['carModelId'] = this.carModelId;
    data['carModelDescription'] = this.carModelDescription;
    data['brandId'] = this.brandId;
    data['brandDescription'] = this.brandDescription;
    data['persianYear'] = this.persianYear;
    data['miladiYear'] = this.miladiYear;
    data['colorId'] = this.colorId;
    data['colorDescription'] = this.colorDescription;
    data['trimColorId'] = this.trimColorId;
    data['trimColorDescription'] = this.trimColorDescription;
    data['carId'] = this.carId;
    data['chassisNumber'] = this.chassisNumber;
    data['manufactureYearId'] = this.manufactureYearId;
    data['mileage'] = this.mileage;
    data['mileageState'] = this.mileageState;
    data['carDescription'] = this.carDescription;
    data['expertBranchId'] = this.expertBranchId;
    data['expertBranchDescription'] = this.expertBranchDescription;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userLastName'] = this.userLastName;
    data['userCellNumber'] = this.userCellNumber;
    data['itemTypeComment1'] = this.itemTypeComment1;
    data['itemTypeComment2'] = this.itemTypeComment2;
    data['itemTypeComment3'] = this.itemTypeComment3;
    data['itemTypeComment4'] = this.itemTypeComment4;
    data['itemTypeComment5'] = this.itemTypeComment5;
    data['itemTypeComment6'] = this.itemTypeComment6;
    data['itemTypeComment7'] = this.itemTypeComment7;
    data['finalStep'] = this.finalStep;
    data['expertPrice'] = this.expertPrice;
    data['supervisorPrice'] = this.supervisorPrice;
    data['branchName'] = this.branchName;
    data['branchAddress'] = this.branchAddress;
    data['registerDate'] = this.registerDate;
    data['receptionNumber'] = this.receptionNumber;
    data['receptionDate'] = this.receptionDate;
    data['currentMileage'] = this.currentMileage;
    data['receptionTime'] = this.receptionTime;
    data['receptionHour'] = this.receptionHour;
    data['carOwner'] = this.carOwner;
    data['referredName'] = this.referredName;
    data['referredCellNumber'] = this.referredCellNumber;
    data['referredAddress'] = this.referredAddress;
    data['referredNationalId'] = this.referredNationalId;
    data['referredPostalcode'] = this.referredPostalcode;
    data['paymentType'] = this.paymentType;
    data['carBodyDetails'] = this.carBodyDetails;
    data['q1Value'] = this.q1Value;
    data['q2Value'] = this.q2Value;
    data['rateComment'] = this.rateComment;
    data['bodyDetails'] = this.bodyDetails;
    data['documents'] = this.documents;
    data['expertItemValues'] = this.expertItemValues;
    return data;
  }
}
