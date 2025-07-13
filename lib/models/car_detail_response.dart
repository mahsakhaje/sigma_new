import 'package:sigma/models/add_new_car_response.dart';

class CarDetailResponse {
  int? status;
  String? message;
  SalesOrder? salesOrder;

  CarDetailResponse({this.status, this.message, this.salesOrder});

  CarDetailResponse.fromJson(Map<String, dynamic> json) {
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
  String? catalogUrl;
  String? comment;
  String? advertiseComment;
  String? orderAmount;
  String? expertAmount;
  String? expertConfirmAmount;
  String? advertiseAmount;
  String? declaredAmount;
  String? receptionNumber;
  String? receptionDate;
  String? receptionTime;
  String? receptionHour;
  String? referredName;
  String? referredCellNumber;
  String? referredAddress;
  String? referredNationalId;
  String? referredPostalcode;
  String? carOwner;
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
  String? chassisNumber;
  String? owner;
  String? clientSalesOrderNumber;
  String? registeredByAdmin;
  String? showRoomId;
  String? showRoomName;
  String? showRoomTelNumber;
  String? showRoomLat;
  String? showRoomLon;
  String? showRoomAddress;
  String? parkingId;
  String? parkingName;
  String? parkingLat;
  String? parkingLon;
  String? parkingAddress;
  String? registerDate;
  String? expertOrderId;
  String? expertOrderState;
  String? paymentType;
  String? q1Value;
  String? q2Value;
  String? rateComment;
  String? rated;
  String? finalStep;
  String? itemTypeComment1;
  String? itemTypeComment2;
  String? referred;
  String? referredLastName;
  String? timespanDateDescription;
  String? timespanDate;
  String? timespanDescription;
  String? timespanFromHour;
  String? timespanToHour;
  String? accountManagerName;
  String? accountManagerLastName;
  String? accountManagerCellNumber;
  String? contractState;
  String? cancelReasonId;
  String? cancelDescription;
  String? plateNumber;
  String? platePart1;
  String? platePart2;
  String? platePart3;
  String? platePart4;
  String? advertised;
  String? showTransaction;
  String? carId;
  String? bodyDetails;
  List<SalesOrderDocuments>? salesOrderDocuments;
  String? documents;
  String? histories;
  String? justSwap;
  String? salesOrderItemValues;
  String? firstAdvertiseDate;
  String? lastAdvertiseDate;
  List<CarTypeDefaultSpecTypes>? carTypeDefaultSpecTypes;
  bool? validForAdmin;
  bool? validForEstimation;

  SalesOrder(
      {this.id,
      this.state,
      this.stateText,
      this.orderNumber,
      this.comment,
      this.advertiseComment,
      this.orderAmount,
      this.expertAmount,
      this.expertConfirmAmount,
      this.showRoomTelNumber,
      this.advertiseAmount,
      this.justSwap,
      this.declaredAmount,
      this.receptionNumber,
      this.receptionDate,
      this.receptionTime,
      this.receptionHour,
      this.referredName,
      this.catalogUrl,
      this.referredCellNumber,
      this.referredAddress,
      this.referredNationalId,
      this.referredPostalcode,
      this.carOwner,
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
      this.firstAdvertiseDate,
      this.lastAdvertiseDate,
      this.trimColorId,
      this.trimColorDescription,
      this.timespanCapacityId,
      this.manufactureYearId,
      this.miladiYear,
      this.persianYear,
      this.timespanCapacityDate,
      this.expertBranchId,
      this.expertBranchDescription,
      this.chassisNumber,
      this.owner,
      this.clientSalesOrderNumber,
      this.registeredByAdmin,
      this.showRoomId,
      this.showRoomName,
      this.showRoomLat,
      this.showRoomLon,
      this.showRoomAddress,
      this.parkingId,
      this.parkingName,
      this.parkingLat,
      this.parkingLon,
      this.parkingAddress,
      this.registerDate,
      this.expertOrderId,
      this.expertOrderState,
      this.paymentType,
      this.q1Value,
      this.q2Value,
      this.rateComment,
      this.rated,
      this.finalStep,
      this.itemTypeComment1,
      this.itemTypeComment2,
      this.referred,
      this.referredLastName,
      this.timespanDateDescription,
      this.timespanDate,
      this.timespanDescription,
      this.timespanFromHour,
      this.timespanToHour,
      this.accountManagerName,
      this.accountManagerLastName,
      this.accountManagerCellNumber,
      this.contractState,
      this.cancelReasonId,
      this.cancelDescription,
      this.plateNumber,
      this.platePart1,
      this.platePart2,
      this.platePart3,
      this.platePart4,
      this.advertised,
      this.showTransaction,
      this.carId,
      this.bodyDetails,
      this.salesOrderDocuments,
      this.documents,
      this.histories,
      this.salesOrderItemValues,
      this.carTypeDefaultSpecTypes,
      this.validForAdmin,
      this.validForEstimation});

  SalesOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    justSwap = json['justSwap'];
    firstAdvertiseDate = json['firstAdvertiseDate'];
    lastAdvertiseDate = json['lastAdvertiseDate'];
    state = json['state'];
    stateText = json['stateText'];
    orderNumber = json['orderNumber'];
    comment = json['comment'];
    advertiseComment = json['advertiseComment'];
    orderAmount = json['orderAmount'];
    expertAmount = json['expertAmount'];
    catalogUrl = json['catalogUrl'];
    expertConfirmAmount = json['expertConfirmAmount'];
    advertiseAmount = json['advertiseAmount'];
    declaredAmount = json['declaredAmount'];
    receptionNumber = json['receptionNumber'];
    receptionDate = json['receptionDate'];
    receptionTime = json['receptionTime'];
    receptionHour = json['receptionHour'];
    showRoomTelNumber = json['showRoomTelNumber'];
    referredName = json['referredName'];
    referredCellNumber = json['referredCellNumber'];
    referredAddress = json['referredAddress'];
    referredNationalId = json['referredNationalId'];
    referredPostalcode = json['referredPostalcode'];
    carOwner = json['carOwner'];
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
    chassisNumber = json['chassisNumber'];
    owner = json['owner'];
    clientSalesOrderNumber = json['clientSalesOrderNumber'];
    registeredByAdmin = json['registeredByAdmin'];
    showRoomId = json['showRoomId'];
    showRoomName = json['showRoomName'];
    showRoomLat = json['showRoomLat'];
    showRoomLon = json['showRoomLon'];
    showRoomAddress = json['showRoomAddress'];
    parkingId = json['parkingId'];
    parkingName = json['parkingName'];
    parkingLat = json['parkingLat'];
    parkingLon = json['parkingLon'];
    parkingAddress = json['parkingAddress'];
    registerDate = json['registerDate'];
    expertOrderId = json['expertOrderId'];
    expertOrderState = json['expertOrderState'];
    paymentType = json['paymentType'];
    q1Value = json['q1Value'];
    q2Value = json['q2Value'];
    rateComment = json['rateComment'];
    rated = json['rated'];
    finalStep = json['finalStep'];
    itemTypeComment1 = json['itemTypeComment1'];
    itemTypeComment2 = json['itemTypeComment2'];
    referred = json['referred'];
    referredLastName = json['referredLastName'];
    timespanDateDescription = json['timespanDateDescription'];
    timespanDate = json['timespanDate'];
    timespanDescription = json['timespanDescription'];
    timespanFromHour = json['timespanFromHour'];
    timespanToHour = json['timespanToHour'];
    accountManagerName = json['accountManagerName'];
    accountManagerLastName = json['accountManagerLastName'];
    accountManagerCellNumber = json['accountManagerCellNumber'];
    contractState = json['contractState'];
    cancelReasonId = json['cancelReasonId'];
    cancelDescription = json['cancelDescription'];
    plateNumber = json['plateNumber'];
    platePart1 = json['platePart1'];
    platePart2 = json['platePart2'];
    platePart3 = json['platePart3'];
    platePart4 = json['platePart4'];
    advertised = json['advertised'];
    showTransaction = json['showTransaction'];
    carId = json['carId'];
    bodyDetails = json['bodyDetails'];
    if (json['salesOrderDocuments'] != null) {
      salesOrderDocuments = <SalesOrderDocuments>[];
      json['salesOrderDocuments'].forEach((v) {
        salesOrderDocuments!.add(new SalesOrderDocuments.fromJson(v));
      });
    }
    documents = json['documents'];
    histories = json['histories'];
    salesOrderItemValues = json['salesOrderItemValues'];

    if (json['carTypeDefaultSpecTypes'] != null) {
      carTypeDefaultSpecTypes = <CarTypeDefaultSpecTypes>[];
      json['carTypeDefaultSpecTypes'].forEach((v) {
        carTypeDefaultSpecTypes!.add(new CarTypeDefaultSpecTypes.fromJson(v));
      });
    }

    validForAdmin = json['validForAdmin'];
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
    data['expertAmount'] = this.expertAmount;
    data['expertConfirmAmount'] = this.expertConfirmAmount;
    data['advertiseAmount'] = this.advertiseAmount;
    data['declaredAmount'] = this.declaredAmount;
    data['receptionNumber'] = this.receptionNumber;
    data['receptionDate'] = this.receptionDate;
    data['receptionTime'] = this.receptionTime;
    data['receptionHour'] = this.receptionHour;
    data['referredName'] = this.referredName;
    data['referredCellNumber'] = this.referredCellNumber;
    data['referredAddress'] = this.referredAddress;
    data['referredNationalId'] = this.referredNationalId;
    data['referredPostalcode'] = this.referredPostalcode;
    data['carOwner'] = this.carOwner;
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
    data['chassisNumber'] = this.chassisNumber;
    data['owner'] = this.owner;
    data['clientSalesOrderNumber'] = this.clientSalesOrderNumber;
    data['registeredByAdmin'] = this.registeredByAdmin;
    data['showRoomId'] = this.showRoomId;
    data['showRoomName'] = this.showRoomName;
    data['showRoomLat'] = this.showRoomLat;
    data['showRoomLon'] = this.showRoomLon;
    data['showRoomAddress'] = this.showRoomAddress;
    data['parkingId'] = this.parkingId;
    data['parkingName'] = this.parkingName;
    data['parkingLat'] = this.parkingLat;
    data['parkingLon'] = this.parkingLon;
    data['parkingAddress'] = this.parkingAddress;
    data['registerDate'] = this.registerDate;
    data['expertOrderId'] = this.expertOrderId;
    data['expertOrderState'] = this.expertOrderState;
    data['paymentType'] = this.paymentType;
    data['q1Value'] = this.q1Value;
    data['q2Value'] = this.q2Value;
    data['rateComment'] = this.rateComment;
    data['rated'] = this.rated;
    data['finalStep'] = this.finalStep;
    data['itemTypeComment1'] = this.itemTypeComment1;
    data['itemTypeComment2'] = this.itemTypeComment2;
    data['referred'] = this.referred;
    data['referredLastName'] = this.referredLastName;
    data['timespanDateDescription'] = this.timespanDateDescription;
    data['timespanDate'] = this.timespanDate;
    data['timespanDescription'] = this.timespanDescription;
    data['timespanFromHour'] = this.timespanFromHour;
    data['timespanToHour'] = this.timespanToHour;
    data['accountManagerName'] = this.accountManagerName;
    data['accountManagerLastName'] = this.accountManagerLastName;
    data['accountManagerCellNumber'] = this.accountManagerCellNumber;
    data['contractState'] = this.contractState;
    data['cancelReasonId'] = this.cancelReasonId;
    data['cancelDescription'] = this.cancelDescription;
    data['plateNumber'] = this.plateNumber;
    data['platePart1'] = this.platePart1;
    data['platePart2'] = this.platePart2;
    data['platePart3'] = this.platePart3;
    data['platePart4'] = this.platePart4;
    data['advertised'] = this.advertised;
    data['showTransaction'] = this.showTransaction;
    data['carId'] = this.carId;
    data['bodyDetails'] = this.bodyDetails;
    if (this.salesOrderDocuments != null) {
      data['salesOrderDocuments'] =
          this.salesOrderDocuments!.map((v) => v.toJson()).toList();
    }
    data['documents'] = this.documents;
    data['histories'] = this.histories;
    data['salesOrderItemValues'] = this.salesOrderItemValues;
    data['carTypeDefaultSpecTypes'] = this.carTypeDefaultSpecTypes;
    data['validForAdmin'] = this.validForAdmin;
    data['validForEstimation'] = this.validForEstimation;
    return data;
  }
}

class SalesOrderDocuments {
  String? id;
  String? salesOrderId;
  String? docId;
  String? forAdvertise;
  String? fileType;

  SalesOrderDocuments(
      {this.id,
      this.salesOrderId,
      this.docId,
      this.forAdvertise,
      this.fileType});

  SalesOrderDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesOrderId = json['salesOrderId'];
    docId = json['docId'];
    forAdvertise = json['forAdvertise'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesOrderId'] = this.salesOrderId;
    data['docId'] = this.docId;
    data['forAdvertise'] = this.forAdvertise;
    data['fileType'] = this.fileType;
    return data;
  }
}

class CarTypeDefaultSpecTypes {
  String? id;
  String? description;
  String? isDefault;
  String? carTypeId;
  String? carTypeDescription;
  String? specTypeId;
  String? specTypeDescription;
  String? specGroupId;
  String? specGroupDescription;

  CarTypeDefaultSpecTypes(
      {this.id,
      this.description,
      this.isDefault,
      this.carTypeId,
      this.carTypeDescription,
      this.specTypeId,
      this.specTypeDescription,
      this.specGroupId,
      this.specGroupDescription});

  CarTypeDefaultSpecTypes.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    id = json['id'];
    description = json['description'];
    isDefault = json['isDefault'];
    carTypeId = json['carTypeId'];
    carTypeDescription = json['carTypeDescription'];
    specTypeId = json['specTypeId'];
    specTypeDescription = json['specTypeDescription'];
    specGroupId = json['specGroupId'];
    specGroupDescription = json['specGroupDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['isDefault'] = this.isDefault;
    data['carTypeId'] = this.carTypeId;
    data['carTypeDescription'] = this.carTypeDescription;
    data['specTypeId'] = this.specTypeId;
    data['specTypeDescription'] = this.specTypeDescription;
    data['specGroupId'] = this.specGroupId;
    data['specGroupDescription'] = this.specGroupDescription;
    return data;
  }
}
