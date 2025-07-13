class GetExpertAmountResponse {
  int? status;
  String? message;
  SalesOrder? salesOrder;

  GetExpertAmountResponse({this.status, this.message, this.salesOrder});

  GetExpertAmountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    salesOrder = json['salesOrder'] != null
        ? new SalesOrder.fromJson(json['salesOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.salesOrder != null) {
      data['salesOrder'] = this.salesOrder!.toJson();
    }
    return data;
  }
}

class SalesOrder {
  String? id;
  String? state;
  String? stateText;
  String? orderNumber;
  String? comment;
  String? advertiseComment;
  String? orderAmount;
  String? declaredAmount;
  String? soldAmount;
  String? transactionDate;
  String? transactionPrice;
  String? accountName;
  String? accountLastName;
  String? accountCellNumber;
  String? carTypeId;
  String? carTypeDescription;
  String? carModelDescription;
  String? carModelId;
  String? brandId;
  String? brandDescription;
  String? favCount;
  String? mileageState;
  String? mileage;
  String? colorId;
  String? colorCode;
  String? colorDescription;
  String? trimColorId;
  String? trimColorDescription;
  String? timespanCapacityId;
  String? manufactureYearId;
  String? miladiYear;
  String? persianYear;
  String? timespanCapacityDate;
  String? expertBranchId;
  String? expertBranchDescription;
  String? expertAmount;
  String? chassisNumber;
  String? owner;
  String? clientSalesOrderNumber;
  String? registeredByAdmin;
  String? showRoomId;
  String? showRoomName;
  String? showRoomAddress;
  String? registerDate;
  String? expertOrderId;
  String? expertOrderState;
  String? paymentType;
  String? q1Value;
  String? q2Value;
  String? rateComment;
  String? salesOrderDocuments;
  String? documents;
  String? histories;
  bool? validForEstimation;

  SalesOrder(
      {this.id,
        this.state,
        this.stateText,
        this.orderNumber,
        this.comment,
        this.advertiseComment,
        this.orderAmount,
        this.declaredAmount,
        this.soldAmount,
        this.transactionDate,
        this.transactionPrice,
        this.accountName,
        this.accountLastName,
        this.accountCellNumber,
        this.carTypeId,
        this.carTypeDescription,
        this.carModelDescription,
        this.carModelId,
        this.brandId,
        this.brandDescription,
        this.favCount,
        this.mileageState,
        this.mileage,
        this.colorId,
        this.colorCode,
        this.colorDescription,
        this.trimColorId,
        this.trimColorDescription,
        this.timespanCapacityId,
        this.manufactureYearId,
        this.miladiYear,
        this.persianYear,
        this.timespanCapacityDate,
        this.expertBranchId,
        this.expertBranchDescription,
        this.expertAmount,
        this.chassisNumber,
        this.owner,
        this.clientSalesOrderNumber,
        this.registeredByAdmin,
        this.showRoomId,
        this.showRoomName,
        this.showRoomAddress,
        this.registerDate,
        this.expertOrderId,
        this.expertOrderState,
        this.paymentType,
        this.q1Value,
        this.q2Value,
        this.rateComment,
        this.salesOrderDocuments,
        this.documents,
        this.histories,
        this.validForEstimation});

  SalesOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    stateText = json['stateText'];
    orderNumber = json['orderNumber'];
    comment = json['comment'];
    advertiseComment = json['advertiseComment'];
    orderAmount = json['orderAmount'];
    declaredAmount = json['declaredAmount'];
    soldAmount = json['soldAmount'];
    transactionDate = json['transactionDate'];
    transactionPrice = json['transactionPrice'];
    accountName = json['accountName'];
    accountLastName = json['accountLastName'];
    accountCellNumber = json['accountCellNumber'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    carModelDescription = json['carModelDescription'];
    carModelId = json['carModelId'];
    brandId = json['brandId'];
    brandDescription = json['brandDescription'];
    favCount = json['favCount'];
    mileageState = json['mileageState'];
    mileage = json['mileage'];
    colorId = json['colorId'];
    colorCode = json['colorCode'];
    colorDescription = json['colorDescription'];
    trimColorId = json['trimColorId'];
    trimColorDescription = json['trimColorDescription'];
    timespanCapacityId = json['timespanCapacityId'];
    manufactureYearId = json['manufactureYearId'];
    miladiYear = json['miladiYear'];
    persianYear = json['persianYear'];
    timespanCapacityDate = json['timespanCapacityDate'];
    expertBranchId = json['expertBranchId'];
    expertBranchDescription = json['expertBranchDescription'];
    expertAmount = json['expertAmount'];
    chassisNumber = json['chassisNumber'];
    owner = json['owner'];
    clientSalesOrderNumber = json['clientSalesOrderNumber'];
    registeredByAdmin = json['registeredByAdmin'];
    showRoomId = json['showRoomId'];
    showRoomName = json['showRoomName'];
    showRoomAddress = json['showRoomAddress'];
    registerDate = json['registerDate'];
    expertOrderId = json['expertOrderId'];
    expertOrderState = json['expertOrderState'];
    paymentType = json['paymentType'];
    q1Value = json['q1Value'];
    q2Value = json['q2Value'];
    rateComment = json['rateComment'];
    salesOrderDocuments = json['salesOrderDocuments'];
    documents = json['documents'];
    histories = json['histories'];
    validForEstimation = json['validForEstimation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['stateText'] = this.stateText;
    data['orderNumber'] = this.orderNumber;
    data['comment'] = this.comment;
    data['advertiseComment'] = this.advertiseComment;
    data['orderAmount'] = this.orderAmount;
    data['declaredAmount'] = this.declaredAmount;
    data['soldAmount'] = this.soldAmount;
    data['transactionDate'] = this.transactionDate;
    data['transactionPrice'] = this.transactionPrice;
    data['accountName'] = this.accountName;
    data['accountLastName'] = this.accountLastName;
    data['accountCellNumber'] = this.accountCellNumber;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['carModelDescription'] = this.carModelDescription;
    data['carModelId'] = this.carModelId;
    data['brandId'] = this.brandId;
    data['brandDescription'] = this.brandDescription;
    data['favCount'] = this.favCount;
    data['mileageState'] = this.mileageState;
    data['mileage'] = this.mileage;
    data['colorId'] = this.colorId;
    data['colorCode'] = this.colorCode;
    data['colorDescription'] = this.colorDescription;
    data['trimColorId'] = this.trimColorId;
    data['trimColorDescription'] = this.trimColorDescription;
    data['timespanCapacityId'] = this.timespanCapacityId;
    data['manufactureYearId'] = this.manufactureYearId;
    data['miladiYear'] = this.miladiYear;
    data['persianYear'] = this.persianYear;
    data['timespanCapacityDate'] = this.timespanCapacityDate;
    data['expertBranchId'] = this.expertBranchId;
    data['expertBranchDescription'] = this.expertBranchDescription;
    data['expertAmount'] = this.expertAmount;
    data['chassisNumber'] = this.chassisNumber;
    data['owner'] = this.owner;
    data['clientSalesOrderNumber'] = this.clientSalesOrderNumber;
    data['registeredByAdmin'] = this.registeredByAdmin;
    data['showRoomId'] = this.showRoomId;
    data['showRoomName'] = this.showRoomName;
    data['showRoomAddress'] = this.showRoomAddress;
    data['registerDate'] = this.registerDate;
    data['expertOrderId'] = this.expertOrderId;
    data['expertOrderState'] = this.expertOrderState;
    data['paymentType'] = this.paymentType;
    data['q1Value'] = this.q1Value;
    data['q2Value'] = this.q2Value;
    data['rateComment'] = this.rateComment;
    data['salesOrderDocuments'] = this.salesOrderDocuments;
    data['documents'] = this.documents;
    data['histories'] = this.histories;
    data['validForEstimation'] = this.validForEstimation;
    return data;
  }
}
