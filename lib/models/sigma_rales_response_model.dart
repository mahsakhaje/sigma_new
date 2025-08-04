class SigmaSalesOrderResponse {
  int? status;
  String? message;
  String? count;
  List<SalesOrders>? salesOrders;

  SigmaSalesOrderResponse(
      {this.status, this.message, this.count, this.salesOrders});

  SigmaSalesOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['salesOrders'] != null) {
      salesOrders = <SalesOrders>[];
      json['salesOrders'].forEach((v) {
        salesOrders!.add(new SalesOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.salesOrders != null) {
      data['salesOrders'] = this.salesOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesOrders {
  String? id;
  String? state;
  String? stateText;
  String? provinceDescription;
  String? orderNumber;
  String? comment;
  String? registerTime;
  String? advertiseComment;
  String? orderAmount;
  String? declaredAmount;
  String? soldAmount;
  String? advertiseAmount;
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
  String? timespanDate;
  String? timespanDateDescription;
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
  String? justSwap;
  String? clientSalesOrderNumber;
  String? registeredByAdmin;
  String? showRoomId;
  String? showRoomName;
  String? accountManagerName;
  String? accountManagerLastName;
  String? showRoomAddress;
  String? registerDate;
  String? expertOrderId;
  String? expertOrderState;
  String? paymentType;
  String? q1Value;
  String? q2Value;
  String? rated;
  String? receptionDate;
  String? receptionTime;
  String? rateComment;
  List<SalesOrderDocuments>? salesOrderDocuments;
  String? documents;
  List<Histories>? histories;
  bool? validForEstimation;

  SalesOrders(
      {this.id,
      this.state,
      this.stateText,
      this.orderNumber,
      this.comment,
      this.advertiseComment,
      this.orderAmount,
      this.declaredAmount,
      this.soldAmount,
      this.registerTime,
      this.provinceDescription,
      this.timespanDate,
      this.accountManagerName,
      this.accountManagerLastName,
      this.timespanDateDescription,
      this.receptionDate,
      this.justSwap,
      this.receptionTime,
      this.transactionDate,
      this.transactionPrice,
      this.accountName,
      this.rated,
      this.accountLastName,
      this.accountCellNumber,
      this.carTypeId,
      this.carTypeDescription,
      this.carModelDescription,
      this.carModelId,
      this.advertiseAmount,
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

  SalesOrders.fromJson(Map<String, dynamic> json) {
    print(json['timespanDateDescription']);
    advertiseAmount = json['advertiseAmount'];
    id = json['id'];
    justSwap = json['justSwap'];
    rated = json['rated'];
    accountManagerName = json['accountManagerName'];
    accountManagerLastName = json['accountManagerLastName'];
    provinceDescription = json['provinceDescription'];
    timespanDate = json['timespanDate'];
    timespanDateDescription = json['timespanDateDescription'];
    registerTime = json['registerTime'];
    state = json['state'];
    receptionTime = json['receptionTime'];
    receptionDate = json['receptionDate'];
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
    if (json['salesOrderDocuments'] != null) {
      salesOrderDocuments = <SalesOrderDocuments>[];
      json['salesOrderDocuments'].forEach((v) {
        salesOrderDocuments!.add(new SalesOrderDocuments.fromJson(v));
      });
    }
    documents = json['documents'];
    if (json['histories'] != null) {
      histories = <Histories>[];
      json['histories'].forEach((v) {
        histories!.add(new Histories.fromJson(v));
      });
    }
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
    if (this.salesOrderDocuments != null) {
      data['salesOrderDocuments'] =
          this.salesOrderDocuments!.map((v) => v.toJson()).toList();
    }
    data['documents'] = this.documents;
    if (this.histories != null) {
      data['histories'] = this.histories!.map((v) => v.toJson()).toList();
    }
    data['validForEstimation'] = this.validForEstimation;
    return data;
  }
}

class SalesOrderDocuments {
  String? id;
  String? salesOrderId;
  String? docId;
  String? forAdvertise;

  SalesOrderDocuments(
      {this.id, this.salesOrderId, this.docId, this.forAdvertise});

  SalesOrderDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesOrderId = json['salesOrderId'];
    docId = json['docId'];
    forAdvertise = json['forAdvertise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesOrderId'] = this.salesOrderId;
    data['docId'] = this.docId;
    data['forAdvertise'] = this.forAdvertise;
    return data;
  }
}

class Histories {
  String? id;
  String? registerDate;
  String? registerTime;
  String? operationDate;
  String? operationTime;
  String? username;
  String? description;
  String? orderId;
  String? operationId;
  String? operationType;
  String? operationDescription;
  bool? validForEstimation;

  Histories(
      {this.id,
      this.registerDate,
      this.registerTime,
      this.operationDate,
      this.operationTime,
      this.username,
      this.description,
      this.orderId,
      this.operationId,
      this.operationType,
      this.operationDescription,
      this.validForEstimation});

  Histories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registerDate = json['registerDate'];
    registerTime = json['registerTime'];
    operationDate = json['operationDate'];
    operationTime = json['operationTime'];
    username = json['username'];
    description = json['description'];
    orderId = json['orderId'];
    operationId = json['operationId'];
    operationType = json['operationType'];
    operationDescription = json['operationDescription'];
    validForEstimation = json['validForEstimation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registerDate'] = this.registerDate;
    data['registerTime'] = this.registerTime;
    data['operationDate'] = this.operationDate;
    data['operationTime'] = this.operationTime;
    data['username'] = this.username;
    data['description'] = this.description;
    data['orderId'] = this.orderId;
    data['operationId'] = this.operationId;
    data['operationType'] = this.operationType;
    data['operationDescription'] = this.operationDescription;
    data['validForEstimation'] = this.validForEstimation;
    return data;
  }
}
